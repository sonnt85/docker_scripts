#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo "$@"
$SUDO docker run --rm --name=bash_${D} \
        ddboline/ddboline_keys:pip_py2deb_latest /home/ubuntu/docker_scripts/run_python_deb_build.sh
