#!/bin/bash

set -eu

CONFIG_FILE=/srv/mendix/.m2ee/m2ee.yaml

APP_PING_PORT=9000
APP_PING_PERIOD=60

sed -i "s/VPC_DB_TYPE/$VPC_DB_TYPE/" $CONFIG_FILE
sed -i "s/VPC_DB_HOSTNAME/$VPC_DB_HOSTNAME/" $CONFIG_FILE
sed -i "s/VPC_DB_DATABASE/$VPC_DB_DATABASE/" $CONFIG_FILE
sed -i "s/VPC_DB_USERNAME/$VPC_DB_USERNAME/" $CONFIG_FILE
sed -i "s/VPC_DB_PASSWORD/$VPC_DB_PASSWORD/" $CONFIG_FILE

m2ee --yolo unpack application.mda
m2ee download_runtime
m2ee --yolo start
m2ee --yolo create_admin_user $VPC_ADMIN_PASSWORD

while [ `nc -z 127.0.0.1 $APP_PING_PORT  && echo $? || echo $?` -eq 0 ]
do
    echo app is running, sleeping for $APP_PING_PERIOD
    sleep $APP_PING_PERIOD
done
