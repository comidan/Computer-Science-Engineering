#!/usr/bin/env bash

apt install default-jre-headless -y

JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
echo "export JAVA_HOME="$JAVA_HOME > /etc/profile.d/set-java-home.sh

# ONOS_VERSION=1.12.0
CACHE_DIR=/vagrant/cache

if [ ! -e $CACHE_DIR ]; then
    mkdir $CACHE_DIR
fi
cd $CACHE_DIR

if [ ! -f onos-$ONOS_VERSION.tar.gz ]; then
    wget -q -c http://downloads.onosproject.org/release/onos-$ONOS_VERSION.tar.gz
fi

cd

tar xf $CACHE_DIR/onos-$ONOS_VERSION.tar.gz
ln -s onos-$ONOS_VERSION onos

#echo "export PATH=\$PATH:/opt/onos/bin " >> .bashrc
