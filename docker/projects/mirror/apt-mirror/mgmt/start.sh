#!/bin/bash

[ -d /var/spool/apt-mirror ] || mkdir /var/spool/apt-mirror
docker run --name apt-mirror --restart=always -d -v /var/spool/apt-mirror:/var/spool/apt-mirror -it apt-mirror
