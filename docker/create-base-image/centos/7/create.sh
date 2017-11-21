#!/bin/sh
#MAINTAINER hepeiqin@casachina.com.cn
IMAGE_NAME=centos:7
ISO_MNT_DIR=$PWD/centos-repo
RPM_ROOT_DIR=$PWD/centos-root
echo $ISO_MNT_DIR
echo $RPM_ROOT_DIR
mkdir $ISO_MNT_DIR
mount -o loop CentOS-7-x86_64-Everything-1611.iso $ISO_MNT_DIR
apt-get install yum
mkdir $RPM_ROOT_DIR
rpm --root $RPM_ROOT_DIR --initdb
rpm --root $RPM_ROOT_DIR -ivh $ISO_MNT_DIR/Packages/centos-release-7-3.1611.el7.centos.x86_64.rpm
mkdir $RPM_ROOT_DIR/etc/yum.repos.d
rm -rvf $RPM_ROOT_DIR/etc/yum.repos.d/*
echo "
[centos-media]
baseurl=file://$ISO_MNT_DIR
enabled=1
" > $RPM_ROOT_DIR/etc/yum.repos.d/centos-media.repo
rpm --root $RPM_ROOT_DIR --import $ISO_MNT_DIR/RPM-GPG-KEY-CentOS-*
yum -y --installroot=$RPM_ROOT_DIR install yum
rm -rvf $RPM_ROOT_DIR/etc/yum.repos.d/*
echo Creating docker image $IMAGE_NAME from $RPM_ROOT_DIR
tar -C $RPM_ROOT_DIR/ -c . | docker import - $IMAGE_NAME
echo Creating docker image $IMAGE_NAEM success
echo Clearing tmp data
umount $ISO_MNT_DIR
rm -rf $ISO_MNT_DIR
rm -rf $RPM_ROOT_DIR
