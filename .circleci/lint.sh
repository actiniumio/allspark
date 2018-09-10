#!/bin/bash

set -xe

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export PATH=$PATH:/root/.local/bin

pip install --user -r $SCRIPT_DIR/requirements.txt

pushd $SCRIPT_DIR/../

ansible-lint install.yml -c $SCRIPT_DIR/.ansible-lint
ansible-lint setup.yml -c $SCRIPT_DIR/.ansible-lint
ansible-lint release.yml -c $SCRIPT_DIR/.ansible-lint
ansible-lint restore.yml -c $SCRIPT_DIR/.ansible-lint
ansible-lint backup.yml -c $SCRIPT_DIR/.ansible-lint
ansible-lint roles/**/tasks/* -c $SCRIPT_DIR/.ansible-lint

popd
