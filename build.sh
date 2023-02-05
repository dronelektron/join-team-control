#!/bin/bash

PLUGIN_NAME="join-team-control"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -o ../plugins/$PLUGIN_NAME.smx
