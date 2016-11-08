#!/bin/bash

set -eu

function test_command() {
    TEST_RES=-1
    eval $2
    TEST_RES=$?
    if [ $TEST_RES -ge 1 ]
    then
        echo ===== Test: "$1", failed
        exit $TEST_RES
    else
        if [ $TEST_RES -lt 0 ]
        then
            echo ===== Test: "$1", not processed correctly
            exit $TEST_RES
        else
            echo ===== Test: "$1", successfull
        fi
    fi
}

function prepare_tests() {
    if [ -f shared_volumes ]; then
        rm -rf shared_volumes;fi
    mkdir -p shared_volumes/dev
    wget https://cdn.mendix.com/sample/sample-690.mda  -O shared_volumes/dev/application.mda
    wget https://cdn.mendix.com/sample/m2ee.compose.test.yaml  -O  shared_volumes/dev//m2ee.test.yaml
}

# test builds
prepare_tests
cd .. && make build-all && cd  test

docker-compose up &

echo "===== waiting 60 secs for docker-compose to start before test"
sleep 30
echo "===== waiting 30 secs for docker-compose to start before test"
sleep 20
echo "===== waiting 10 secs for docker-compose to start before test"
sleep 10

# test mendixapp
test_command "curl mendix app" "curl -vs -k https://127.0.0.1/  2>&1 | grep mxclient > /dev/null  2>&1"

# test vpcdeployer
test_command "curl vpcdeployer" "curl -vs -k https://127.0.0.1/vpcdeployer/  2>&1 | grep mxclient > /dev/null  2>&1"

docker-compose down

rm -rf shared_volumes

echo "===== TESTS complete"

exit 0
