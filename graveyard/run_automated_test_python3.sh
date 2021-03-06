#!/bin/bash

SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`

if [ -z $1 ]; then
    REPOS="aws_scripts gapi_scripts garmin_app programming_tests"
else
    REPOS="$@"
fi

for REPO in $REPOS;
do
    $SUDO docker run --name=${REPO}_${D} -d ddboline/ddboline_keys:latest /home/ubuntu/run_testing_python3.sh ${REPO}
done
