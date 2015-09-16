#!/bin/bash
##
# File: post-install-slave.sh
#
# Copy necessary Brooklyn setup files to run Brooklyn Integration / Live tests.
#
# Copyright 2015 by Cloudsoft Corp.
##
#set -x # DEBUG

# Copy files sent through Jenkins into ~/.brooklyn folder
mkdir -p ~/.brooklyn
cp /mnt/jenkins/*.* ~/.brooklyn/
chmod 600 ~/.brooklyn/brooklyn.properties
