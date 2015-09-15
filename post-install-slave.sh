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

# Add geolocation db
mkdir -p ~/.brooklyn
cp ~/brooklyn-setup/* ~/.brooklyn
if [ ! -z $YUM ]; then
        sudo chown -R ec2-user:ec2-user ~/.brooklyn/
elif [ ! -z $APT_GET ]; then
        sudo chown -R ubuntu:ubuntu ~/.brooklyn/
else
        echo "Error: cannot figure out the default user / group"
        exit 1;
fi
