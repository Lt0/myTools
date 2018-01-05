#!/bin/sh

docker run --name apk-mirror --restart=always -d -v /media/nas-0/mirror/apk:/apk-mirror -it apk-mirror
