#!/bin/bash

set -xeu pipefail

if [ -z "$JENKINS_USER" -o -z "$JENKINS_PASSWORD" ]
then
  echo "Missing credentials"
  echo "One of theses variables wasn't set:"
  echo "- JENKINS_USER"
  echo "- JENKINS_PASSWORD"
  exit 1
fi

if [ -z "$JENKINS_URL" ]
then
  echo "Variable JENKINS_URL missing"
  exit 2
fi

if [ -z "$JENKINS_AGENT_NAME" ]
then
  echo "Variable JENKINS_AGENT_NAME missing"
  exit 3
fi


# Fails and exit if Jenkins is not ready
curl -kL -s $JENKINS_URL > /dev/null

CRUMB=$(curl --fail -0 -u "${JENKINS_USER}:${JENKINS_PASSWORD}" ''${JENKINS_URL}'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)' 2>/dev/null || echo "N/A")

cat > request.json << EOF
{
   "name":"$JENKINS_AGENT_NAME",
   "nodeDescription":"Jenkins slave provisionned by Allspark",
   "numExecutors":"1",
   "remoteFS":"/home/jenkins/agent",
   "labelString":"",
   "mode":"NORMAL",
   "":[
      "hudson.slaves.JNLPLauncher",
      "hudson.slaves.RetentionStrategy\$Always"
   ],
   "launcher":{
      "stapler-class":"hudson.slaves.JNLPLauncher",
      "\$class":"hudson.slaves.JNLPLauncher",
      "workDirSettings":{
         "disabled":false,
         "workDirPath":"",
         "internalDir":"remoting",
         "failIfWorkDirIsMissing":false
      },
      "tunnel":"",
      "vmargs":""
   },
   "retentionStrategy":{
      "stapler-class":"hudson.slaves.RetentionStrategy\$Always",
      "\$class":"hudson.slaves.RetentionStrategy\$Always"
   },
   "nodeProperties":{
      "stapler-class-bag":"true"
   },
   "type":"hudson.slaves.DumbSlave",
   "Jenkins-Crumb":"$CRUMB"
}
EOF

NODE_EXISTS_CODE=$(curl -L -s  \
  -o /dev/null \
  -w "%{http_code}" \
  -u "${JENKINS_USER}:${JENKINS_PASSWORD}" \
  "${JENKINS_URL}/computer/${JENKINS_AGENT_NAME}" \
)

if [ "${NODE_EXISTS_CODE}" -eq "404" ]; then
  echo "Node $JENKINS_AGENT_NAME does not exist, creating it."
  RESPONSE=$(
    curl -L -s  \
      -o /dev/null \
      -w "%{http_code}" \
      -u "${JENKINS_USER}:${JENKINS_PASSWORD}" \
      -H "Content-Type:application/x-www-form-urlencoded" \
      -H "$CRUMB" \
      -X POST \
      -d "json=$(cat request.json)" \
      "${JENKINS_URL}/computer/doCreateItem?name=${JENKINS_AGENT_NAME}&type=hudson.slaves.DumbSlave" \
  )

  if [ "${RESPONSE}" == "200" ]; then
    echo "Node created"
  else
    echo "ERROR: Failed to create node. Response code: [${RESPONSE}]"
    exit 1
  fi
else
  echo "Node is already present, skipping creation"
fi

JENKINS_SECRET=$(
  curl \
    -u "${JENKINS_USER}:${JENKINS_PASSWORD}" \
    "${JENKINS_URL}/computer/${JENKINS_AGENT_NAME}/slave-agent.jnlp" \
  | sed -r 's/.*<application-desc main-class="hudson.remoting.jnlp.Main"><argument>([a-z0-9]*).*/\1/' \
)

JENKINS_NAME=$JENKINS_AGENT_NAME

unset JENKINS_USER
unset JENKINS_PASSWORD
unset JENKINS_AGENT_NAME

jenkins-slave $JENKINS_SECRET $JENKINS_NAME
