#!/bin/bash
set -e

f=$(mktemp)

cat > $f << EOF
set -xe
# Install pip
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py
rm get-pip.py

yum install -y epel-release yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

pushd /packages
mkdir -p pip rpm
pushd rpm
# Releases at https://download.docker.com/linux/centos/7/x86_64/stable/Packages/
curl -O https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-18.03.1.ce-1.el7.centos.x86_64.rpm
yumdownloader --resolve \
  python-kerberos \
  python-pip \
  gcc \
  ansible \
  docker-ce

# Command to install dependencies : "rpm -Uvh --replacefiles *.rpm"

popd
pushd pip
pip download \
  docker \
  requests \
  python-ldap
popd
popd
chown \$USER_ID -R /packages
EOF

chmod +x $f

docker run  \
  -e USER_ID=`id -u $USER` \
  -v $f:/app.sh \
  -v $1:/packages \
  centos:7 \
  bash /app.sh

rm $f
