#!/bin/bash
##
# File: post-install-slave.sh
#
# Copy necessary Brooklyn setup files to run Brooklyn Integration / Live tests.
#
# Copyright 2015 by Cloudsoft Corp.
##
#set -x # DEBUG

# Move Brooklyn files sent through Jenkins into ~/.brooklyn folder
mkdir -p ~/.brooklyn
mv /mnt/jenkins/brooklyn.properties ~/.brooklyn/
mv /mnt/jenkins/GeoLite2-City.mmdb ~/.brooklyn/
chmod 600 ~/.brooklyn/brooklyn.properties
chmod a+r ~/.brooklyn/GeoLite2-City.mmdb

# Move Maven files sent through Jenkins into ~/.m2 folder
mkdir -p ~/.m2
mv /mnt/jenkins/settings.xml ~/.m2/
