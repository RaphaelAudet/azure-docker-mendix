#!/bin/bash

set -e

if [ -z $PACKAGE_SRC ]; then PACKAGE_SRC=/opt/mendix/application.mda; fi
if [ -z $CONFIG_SRC ]; then CONFIG_SRC=/opt/mendix/m2ee.yaml; fi

PACKAGE_DEST=/srv/mendix/data/model-upload/application.mda
CONFIG_DEST=/srv/mendix/.m2ee/m2ee.yaml

APP_PING_PORT=8000
APP_PING_PERIOD=60

ADMIN_PASSWORD=$ADMIN_PASSWORD

if [ -f $PACKAGE_SRC ]
then
    cp $PACKAGE_SRC $PACKAGE_DEST
else
    if [ ! -z "$PACKAGE_URL" ]
    then
        wget "$PACKAGE_URL" -O "$PACKAGE_DEST"
    else
        echo no PACKAGE_SRC and no PACKAGE_URL, exiting
        exit 1
    fi
fi


if [ -f $CONFIG_SRC ]
then
    cp $CONFIG_SRC $CONFIG_DEST
else
    if [ ! -z "$CONFIG_URL" ]
    then
        echo no CONFIG_FILE provided and CONFIG_URL found
        wget "$CONFIG_URL" -O "$CONFIG_DEST"
    else
        echo no CONFIG_FILE and no CONFIG_URL, using default m2ee.yaml
        exit 2
    fi
fi

sed -i "s/DATABASETYPE/$DATABASETYPE/" $CONFIG_DEST
sed -i "s/DATABASEHOSTNAME/$DATABASEHOSTNAME/" $CONFIG_DEST
sed -i "s/DATABASE_DB_NAME/$DATABASE_DB_NAME/" $CONFIG_DEST
sed -i "s/DATABASEUSERNAME/$DATABASEUSERNAME/" $CONFIG_DEST
sed -i "s/DATABASEPASSWORD/$DATABASEPASSWORD/" $CONFIG_DEST
sed -i "s/STORAGE_CONTAINER/$STORAGE_CONTAINER/" $CONFIG_DEST
sed -i "s/STORAGE_ACCOUNTNAME/$STORAGE_ACCOUNTNAME/" $CONFIG_DEST
sed -i "s/STORAGE_ACCOUNTKEY/${STORAGE_ACCOUNTKEY//\//\\/}/" $CONFIG_DEST

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
