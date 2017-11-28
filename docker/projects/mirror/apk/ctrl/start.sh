#!/bin/sh

docker run --name apk-mirror --restart=always -d -v /var/www/html:/var/www/html -it apk-mirror:alpine
