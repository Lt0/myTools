#!/bin/bash

. ../conf/app.conf
. ../conf/internal.conf

echo IMAGE: $IMAGE
echo CONTAINER: $CONTAINER
echo DOWNLOAD_PATH: $DOWNLOAD_PATH
echo CONF_PATH: $CONF_PATH
echo CONF_FILE: $CONF_FILE

[ -d "$CONF_PATH" ] || mkdir -p $CONF_PATH
[ -f "$CONF_PATH/$CONF_FILE" ] || cp -v ../image/$CONF_FILE $CONF_PATH

docker run --name=$CONTAINER -d -it --restart=always -v /media/nas-2/download/transmission:/download -p 9091:9091 $IMAGE
