#!/bin/sh

. ../conf/app.conf
. ../conf/internal.conf

echo IMAGE: $IMAGE
echo CONTAINER: $CONTAINER
echo DOWNLOAD_PATH: $DOWNLOAD_PATH
echo CONF_PATH: $CONF_PATH

[ -d "$DOWNLOAD_PATH" ] || mkdir -p $DOWNLOAD_PATH
[ -d "$CONF_PATH" ] || mkdir -p $CONF_PATH
[ -f "$CONF_PATH/$CORE_CONF" ] || cp -v ../image/$CORE_CONF $CONF_PATH
[ -f "$CONF_PATH/$WEB_CONF" ] || cp -v ../image/$WEB_CONF $CONF_PATH
[ -f "$CONF_PATH/$AUTH_CONF" ] || cp -v ../image/$AUTH_CONF $CONF_PATH

docker run --name=$CONTAINER -d --restart=always -p 8112:8112 -p 58846:58846 -v $DOWNLOAD_PATH:/download -it $IMAGE
