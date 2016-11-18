#!/bin/bash

set -eu

CONFIG_FILE=/root/.m2ee/m2ee.yaml
PREF_XML=/root/.java/.userPrefs/com/mendix/core/prefs.xml

APP_PING_PORT=9000
APP_PING_PERIOD=60

sed -i "s/VPC_DB_TYPE/$VPC_DB_TYPE/" $CONFIG_FILE
sed -i "s/VPC_DB_HOSTNAME/$VPC_DB_HOSTNAME/" $CONFIG_FILE
sed -i "s/VPC_DB_DATABASE/$VPC_DB_DATABASE/" $CONFIG_FILE
sed -i "s/VPC_DB_USERNAME/$VPC_DB_USERNAME/" $CONFIG_FILE
sed -i "s/VPC_DB_PASSWORD/$VPC_DB_PASSWORD/" $CONFIG_FILE

sed -i "s/PREF_KEY/$VPC_PREF_KEY/" $PREF_XML
sed -i "s/PREF_VALUE/$VPC_PREF_VALUE/" $PREF_XML

m2ee --yolo -c $CONFIG_FILE unpack application.mda
echo "Download runtime started"
m2ee -c $CONFIG_FILE download_runtime >/dev/null 2>&1
echo "Download runtime complete"
m2ee --yolo  -c $CONFIG_FILE start
m2ee --yolo  -c $CONFIG_FILE create_admin_user $VPC_ADMIN_PASSWORD

while [ `nc -z 127.0.0.1 $APP_PING_PORT  && echo $? || echo $?` -eq 0 ]
do
    echo app is running, sleeping for $APP_PING_PERIOD
    sleep $APP_PING_PERIOD
done
