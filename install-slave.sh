#!/bin/bash
##
# File: install-slave.sh
#
# Install all necessary requirements to run Brooklyn Integration / Live tests.
#
# Copyright 2015 by Cloudsoft Corp.
##
#set -x # DEBUG

YUM=$(which yum)
APT_GET=$(which apt-get)
PACKAGES="openjdk-7-jdk maven git-core wget curl rng-tools"

# Install necessary executables
if [ ! -z $YUM ]; then
        sudo yum -y -q install $PACKAGES
elif [ ! -z $APT_GET ]; then
        sudo DEBIAN_FRONTEND=noninteractive apt-get -y -q update
        sudo DEBIAN_FRONTEND=noninteractive apt-get -y -q upgrade
        sudo DEBIAN_FRONTEND=noninteractive apt-get -y -q install $PACKAGES
else
        echo "Error: yum or apt-get not found"
        exit 1;
fi

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

# Install ruby 2.2.* and rubygems through RVM
rvm install 2.2
rvm use 2.2
rvm rubygems current

# Install Knife
gem install knife-solo

# Make sure the machine has a good entropy (see: https://brooklyn.incubator.apache.org/documentation/increase-entropy.html)
if [ ! -z $YUM ]; then
        sudo bash -c "echo EXTRAOPTIONS=\"-r /dev/urandom\" >> /etc/sysconfig/rngd"
        sudo /etc/init.d/rngd start
elif [ ! -z $APT_GET ]; then
        sudo bash -c "echo HRNGDEVICE=/dev/urandom >> /etc/default/rng-tools"
        sudo /etc/init.d/rng-tools start
else
        echo "Error: cannot start rng-toor"
        exit 1;
fi
sudo mv /dev/random /dev/random-real
sudo ln -s /dev/urandom /dev/random

# Create SSH keys and add them as authorized keys
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh-keygen -t rsa -N "mypassphrase" -f ~/.ssh/id_rsa_with_passphrase
cat ~/.ssh/id_rsa_with_passphrase.pub >> ~/.ssh/authorized_keys

# Add host configuration
sudo bash -c "echo 127.0.0.1 localhost1 localhost2 localhost3 localhost4 >> /etc/hosts"
(
    ssh-keyscan -H 127.0.0.1
    ssh-keyscan -H localhost
    ssh-keyscan -H localhost1
    ssh-keyscan -H localhost2
    ssh-keyscan -H localhost3
    ssh-keyscan -H localhost4
) > ~/.ssh/known_hosts
