#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get -o Dpkg::Options::="--force-overwrite" dist-upgrade -y
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev libxslt1-dev libpython3.5-dev \
                        freetds-bin freetds-dev udev libfreetype6-dev libpng12-dev pkg-config \
                        libgeos++-dev

for PKG in `cat ./docker_scripts/run_python3_deb_pkgs.txt`;
do
    ./docker_scripts/build_python3_deb.sh $PKG
    sudo dpkg -i ~/py2deb3/*.deb
    sudo apt-get install -f -y --force-yes
done

### For the record, I really don't like python packages that depend on f***ing node...
# sudo apt-get install -y npm
# sudo ln -s /usr/bin/nodejs /usr/bin/node
# ./docker_scripts/build_python3_deb.sh jupyter

# md5sum /home/${USER}/py2deb3/*.deb > modified.log
# MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
MODIFIED=/home/${USER}/py2deb3/*.deb
if [ -n "$MODIFIED" ]; then
    ssh ubuntu@ddbolineinthecloud.mooo.com "mkdir -p /home/ubuntu/setup_files/deb/py2deb3/py2deb3"
    scp $MODIFIED ubuntu@ddbolineinthecloud.mooo.com:/home/ubuntu/setup_files/deb/py2deb3/py2deb3/
    scp $MODIFIED ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb3/py2deb3/
fi
