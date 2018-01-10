#!/bin/bash

. ../conf/app.conf
. ../conf/internal.conf

docker build -t $IMAGE .
