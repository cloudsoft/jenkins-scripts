#!/bin/bash
##
# File: post-install-slave.sh
#
# Copy necessary Brooklyn setup files to run Brooklyn Integration / Live tests.
#
# Copyright 2015 by Cloudsoft Corp.
##
#set -x # DEBUG

YUM=$(which yum)
APT_GET=$(which apt-get)

# Copy files sent through Jenkins into ~/.brooklyn folder
mkdir -p ~/.brooklyn
cp /var/tmp/*.* ~/.brooklyn/
if [ ! -z $YUM ]; then
        sudo chown -R ec2-user:ec2-user ~/.brooklyn/
elif [ ! -z $APT_GET ]; then
        sudo chown -R ubuntu:ubuntu ~/.brooklyn/
else
        echo "Error: cannot figure out the default user / group"
        exit 1;
fi
