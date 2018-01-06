#!/bin/bash

docker run --name=transmission -d -it --restart=always -v /media/nas-2/download/transmission:/download -p 9091:9091 transmission
