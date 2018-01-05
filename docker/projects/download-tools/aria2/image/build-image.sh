#!/bin/bash

. ../conf/app.conf
. ../conf/internal.conf

echo IMAGE: $IMAGE
echo CONTAINER: $CONTAINER

docker build -t $IMAGE .
