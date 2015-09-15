#!/bin/bash
##
# File: pre-ntegration.sh
#
# Perform all necessary step before a new integration job is launched
#
# Copyright 2015 by Cloudsoft Corp.
##
#set -x # DEBUG

# Ensure that "Build Environment > Copy files into ... workspace ..." lists "brooklyn.properties".
mkdir -p ~/.brooklyn
cp $WORKSPACE/brooklyn.properties ~/.brooklyn/brooklyn.properties
chmod 600 ~/.brooklyn/brooklyn.properties
