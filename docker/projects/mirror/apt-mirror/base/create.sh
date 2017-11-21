#!/bin/bash

MIRROR="http://172.0.5.75/ubuntu"
#MIRROR="http://mirrors.aliyun.com/ubuntu"
VER=trusty
IMAGE=apt-mirror-base

mkdir $VER
echo debootstrap $VER $VER $MIRROR
debootstrap $VER $VER $MIRROR

tar -C $VER -c . | docker import - $IMAGE
