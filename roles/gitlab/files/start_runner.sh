#!/bin/sh

true
while [ $? -eq 0 ]
do
/usr/bin/gitlab-runner unregister --name Allspark
done

/usr/bin/gitlab-runner register \
  --non-interactive \
  --name "Allspark" \
  --url "http://gitlab" \
  --registration-token "$REGISTRATION_TOKEN" \
  --executor "docker" \
  --docker-image "$DEFAULT_RUNNER_IMAGE" \
  --tag-list "docker" \
  --run-untagged \
  --locked="false" \
&& /usr/bin/gitlab-runner \
  run \
  --user=gitlab-runner \
  --working-directory=/home/gitlab-runner
