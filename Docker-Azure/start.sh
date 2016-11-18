#!/bin/bash

set -e

PACKAGE_SRC=/opt/mendix/application.mda
CONFIG_SRC=/opt/mendix/m2ee.yaml

PACKAGE_DEST=/root/data/model-upload/application.mda
CONFIG_DEST=/root/.m2ee/m2ee.yaml
PREF_XML=/root/.java/.userPrefs/com/mendix/core/prefs.xml

APP_PING_PORT=8000
APP_PING_PERIOD=60

if [ -f $PACKAGE_SRC ]
then
    cp $PACKAGE_SRC $PACKAGE_DEST
fi

if [ -f $CONFIG_SRC ]
then
    cp $CONFIG_SRC $CONFIG_DEST
fi

sed -i "s/DATABASETYPE/$DATABASETYPE/" $CONFIG_DEST
sed -i "s/DATABASEHOSTNAME/$DATABASEHOSTNAME/" $CONFIG_DEST
sed -i "s/DATABASE_DB_NAME/$DATABASE_DB_NAME/" $CONFIG_DEST
sed -i "s/DATABASEUSERNAME/$DATABASEUSERNAME/" $CONFIG_DEST
sed -i "s/DATABASEPASSWORD/$DATABASEPASSWORD/" $CONFIG_DEST
sed -i "s/STORAGE_CONTAINER/$STORAGE_CONTAINER/" $CONFIG_DEST
sed -i "s/STORAGE_ACCOUNTNAME/$STORAGE_ACCOUNTNAME/" $CONFIG_DEST
sed -i "s/STORAGE_ACCOUNTKEY/${STORAGE_ACCOUNTKEY//\//\\/}/" $CONFIG_DEST

sed -i "s/PREF_KEY/$PREF_KEY/" $PREF_XML
sed -i "s/PREF_VALUE/$PREF_VALUE/" $PREF_XML

m2ee --yolo unpack application.mda
echo "Download runtime started"
m2ee download_runtime >/dev/null 2>&1
echo "Download runtime complete"
m2ee --yolo start
m2ee --yolo create_admin_user $ADMIN_PASSWORD

while [ `nc -z 127.0.0.1 $APP_PING_PORT  && echo $? || echo $?` -eq 0 ]
do
    echo app is running, sleeping for $APP_PING_PERIOD
    sleep $APP_PING_PERIOD
done
