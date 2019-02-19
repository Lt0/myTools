#!/bin/bash

set -eo

mkdir -p xenial
cd xenial
debootstrap --arch=i386 xenial xenial-386
#debootstrap --arch=i386 xenial xenial-386 http://mirrors.aliyun.com/ubuntu
tar -C xenial-386 -c . | docker import - xenial-386
