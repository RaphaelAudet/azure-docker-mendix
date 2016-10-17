#!/bin/bash

set -ex

PACKAGE_PATH=/srv/mendix/data/model-upload
PACKAGE_FILE=$PACKAGE_PATH/application.mda
CONFIG_FILE=/srv/mendix/.m2ee/m2ee.yaml

/usr/bin/curl -o "$PACKAGE_FILE" "$PACKAGE_URL"

if [ ! -z "$CONFIG_URL" ]; then
  /usr/bin/curl -o "$CONFIG_FILE" "$CONFIG_URL"
fi

sed -i "s/DATABASEHOSTNAME/$DATABASEHOSTNAME/" $CONFIG_FILE
sed -i "s/DATABASE_DB_NAME/$DATABASE_DB_NAME/" $CONFIG_FILE
sed -i "s/DATABASEUSERNAME/$DATABASEUSERNAME/" $CONFIG_FILE
sed -i "s/DATABASEPASSWORD/$DATABASEPASSWORD/" $CONFIG_FILE
sed -i "s/STORAGE_CONTAINER/$STORAGE_CONTAINER/" $CONFIG_FILE
sed -i "s/STORAGE_ACCOUNTNAME/$STORAGE_ACCOUNTNAME/" $CONFIG_FILE
sed -i "s/STORAGE_ACCOUNTKEY/$STORAGE_ACCOUNTKEY/" $CONFIG_FILE

m2ee --yolo unpack application.mda
m2ee download_runtime
m2ee --yolo start

if [ "$1" = "start" ]; then
  exec /bin/bash
fi


exec "$@"
