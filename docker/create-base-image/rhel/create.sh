#!/bin/sh
#MAINTAINER hepeiqin@casachina.com.cn
IMAGE_NAME=rhel:7.1
ISO_MNT_DIR=$PWD/rhel-repo
RPM_ROOT_DIR=$PWD/rhel-root
echo $ISO_MNT_DIR
echo $RPM_ROOT_DIR
mkdir $ISO_MNT_DIR
mount -o loop rhel-server-7.1-x86_64-dvd.iso $ISO_MNT_DIR
apt-get install yum
mkdir $RPM_ROOT_DIR
rpm --root $RPM_ROOT_DIR --initdb
rpm --root $RPM_ROOT_DIR -ivh $ISO_MNT_DIR/Packages/redhat-release-server-7.1-1.el7.x86_64.rpm
mkdir $RPM_ROOT_DIR/etc/yum.repos.d
rm -rvf $RPM_ROOT_DIR/etc/yum.repos.d/*
echo "
[rhel71le]
baseurl=file://$ISO_MNT_DIR
enabled=1
" > $RPM_ROOT_DIR/etc/yum.repos.d/rhel71le.repo
rpm --root $RPM_ROOT_DIR --import $ISO_MNT_DIR/RPM-GPG-KEY-redhat-*
yum -y --installroot=$RPM_ROOT_DIR install yum
rm -rvf $RPM_ROOT_DIR/etc/yum.repos.d/*
echo Creating docker image $IMAGE_NAME from $RPM_ROOT_DIR
tar -C $RPM_ROOT_DIR/ -c . | docker import - $IMAGE_NAME
echo Creating docker image $IMAGE_NAEM success
echo Clearing tmp data
umount $ISO_MNT_DIR
rm -rf $ISO_MNT_DIR
rm -rf $RPM_ROOT_DIR
