#!/bin/bash

ECHO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo $1
if [ -z $1 ]; then
    $SUDO docker run -it --name=\"bash_${D}\" --cidfile="$TMP" \
            ddboline/ddboline_keys:conda_latest /bin/bash
    $SUDO docker ps -a
else
    REPO=$1
    $SUDO docker run -it --name=\"${REPO}_${D}\" \
            --cidfile="$TMP" -v ~/setup_files/build/${REPO}:/home/ubuntu/${REPO} \
            ddboline/ddboline_keys:conda_latest /bin/bash \
                -c "sh /home/ubuntu/run_testing_local_conda.sh ${REPO} ; cd /home/ubuntu/${REPO} ; export HOME=/home/ubuntu ; export USER=ubuntu ; /bin/bash"
    ### this has to be done by root...
    sudo chown -R ddboline:ddboline ~/setup_files/build/${REPO}/
fi

sleep 5
$SUDO docker stop `cat $TMP`
sleep 5
$SUDO docker rm `cat $TMP`
$SUDO rm $TMP