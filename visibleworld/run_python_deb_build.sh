#!/bin/bash

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev \
                        libxslt1-dev libpython2.7-dev freetds-bin freetds-dev udev

./build_python_deb.sh packaging appdirs
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/cached-property.git@1.3.0.1
./build_python_deb.sh git+https://github.com/ddboline/chardet.git@2.3.0.1
./build_python_deb.sh git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1
./build_python_deb.sh git+https://github.com/ddboline/python-deb-pkg-tools.git@3.0-1
./build_python_deb.sh git+https://github.com/ddboline/py2deb.git@0.24.3.2

./build_python_deb.sh cython
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.11.3-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/scipy.git@v0.18.1-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh dateutil pytz cycler
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh pandas matplotlib mock pyparsing pbr subprocess32
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/spyder-ide/spyder.git@v2.3.9

for PKG in `cat run_python_deb_pkgs.txt`;
do
    ./build_python_deb.sh $PKG
done
