#!/bin/bash

docker run --name repo-centos-7 --restart=always -d -v /media/hd2/mirrors/reposync/centos/7/:/repository -it repo-centos-7
