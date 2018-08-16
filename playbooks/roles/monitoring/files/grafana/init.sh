#!/bin/sh

echo "Loading admin password"
export GF_SECURITY_ADMIN_PASSWORD=`cat /run/secrets/grafana_admin_password.txt`

echo "Running grafana"
# Container entrypoint
/run.sh
