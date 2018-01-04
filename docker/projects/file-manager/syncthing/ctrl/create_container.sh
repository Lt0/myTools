#!/bin/bash

RUN_USER=vcube
SHARE_PATH="/syncthing"
mkdir $SHARE_PATH
chmod 777 $SHARE_PATH

docker run --name=syncthing --restart=always -d -v $SHARE_PATH:/home/$RUN_USER -p 8384:8384 -p 22000:22000 -it syncthing
