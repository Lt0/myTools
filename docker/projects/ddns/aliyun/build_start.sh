#!/bin/bash

docker rm -f aliddns
docker build -t aliddns .
./start.sh
