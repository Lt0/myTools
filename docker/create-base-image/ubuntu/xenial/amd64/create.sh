#!/bin/bash

set -eo

mkdir -p xenial
cd xenial
debootstrap --arch=amd64 xenial xenial-amd64
#debootstrap --arch=amd64 xenial xenial-amd64 http://mirrors.aliyun.com/ubuntu
tar -C xenial-amd64 -c . | docker import - xenial-amd64
