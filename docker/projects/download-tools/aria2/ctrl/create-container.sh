#!/bin/bash

. ../conf/app.conf
. ../conf/internal.conf

echo IMAGE: $IMAGE
echo CONTAINER: $CONTAINER
echo INER_DOWNLOAD_PATH: $INER_DOWNLOAD_PATH

docker run --name=$CONTAINER -d --restart=always -v /media/nas-2/download/aria2:$INER_DOWNLOAD_PATH -p 6800:6800 -p 6789:80 -it $IMAGE
