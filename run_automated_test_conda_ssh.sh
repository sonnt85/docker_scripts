#!/bin/bash

SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`

if [ -z $1 ]; then
    REPOS="ddboline_personal_scripts blaze_test"
else
    REPOS="$@"
fi

for REPO in $REPOS; # theano_test;
do
    $SUDO docker run --name=\"${REPO}_${D}\" -d ddboline/ddboline_keys:conda_latest /root/run_testing_ssh_conda.sh ${REPO}
done
