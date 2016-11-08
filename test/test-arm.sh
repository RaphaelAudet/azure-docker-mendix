#!/bin/bash

set -xeu

COUNTER=$1
DEPLOYCOUNTER=$2
RG=SmaConTest$COUNTER

TEMPL_JSON=../azure-docker-mendix.json
PARAM_JSON=azure-docker-mendix.parameter.json

azure group create -n $RG -l "westeurope"
azure group deployment create -f $TEMPL_JSON -e $PARAM_JSON -g $RG -n deploy-$DEPLOYCOUNTER
