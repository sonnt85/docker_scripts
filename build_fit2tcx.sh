#!/bin/bash

VERSION="0.4.3"
RELEASE="2"
REPO="https://github.com/adiesner/Fit2Tcx"

sudo apt-get update
sudo apt-get install -y libtinyxml-dev pkg-config \
                        checkinstall

cd ~/

git clone $REPO Fit2Tcx

cd Fit2Tcx

./configure --prefix=/usr
make
printf "\ninstall:\n\tmv fit2tcx /usr/bin/\n" >> Makefile
printf "Convert fit files to tcx\n" > description-pak
### this part is sadly interactive
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} fit2tcx_${VERSION}-${RELEASE}*.deb

cp fit2tcx_${VERSION}-${RELEASE}*.deb ~/py2deb/
cp fit2tcx_${VERSION}-${RELEASE}*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/Fit2Tcx
