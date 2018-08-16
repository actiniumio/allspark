#!/bin/sh

set -e

echo 'Downloading plugins'
docker run \
  --rm \
  -i \
  -u 0 \
  -e "JAVA_OPTS=-Djenkins.install.runSetupWizard=false" \
  -v $VOLUME_NAME:/usr/share/jenkins/ref/plugins/ \
  -v $REQUIREMENTS_FILE:/requirements.txt \
  jenkins/jenkins bash -c 'chown 1000 -R /usr/share/jenkins/ref/plugins && su jenkins install-plugins.sh < /requirements.txt'

echo 'Volume backup'
docker run \
  -v $VOLUME_NAME:/source:ro \
  -v $TARGET:/backup \
  -e "VOLUMERIZE_SOURCE=/source" \
  -e "VOLUMERIZE_TARGET=file:///backup" \
  blacklabelops/volumerize backup

echo 'Fix backup permissions'
docker run \
  -v $TARGET:/source \
  centos:7 chown -R 1000 /source
