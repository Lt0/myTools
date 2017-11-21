#!/bin/sh
#MAINTAINER hepeiqin@casachina.com.cn
IMAGE_NAME=centos:5.4
ISO_MNT_DIR=$PWD/centos-repo
RPM_ROOT_DIR=$PWD/centos-root
ISO_FILE=CentOS-5.4-x86_64-bin-DVD.iso
add_local_repo(){
echo "
[centos-5.4]
name=CentOS-5.4
baseurl=file://$ISO_MNT_DIR
enabled=1
" > $RPM_ROOT_DIR/etc/yum.repos.d/centos5.4.repo
}
reset_repo(){
    echo reset repo
    rm -rvf $RPM_ROOT_DIR/etc/yum.repos.d/*
    add_local_repo
}
echo $ISO_MNT_DIR
echo $RPM_ROOT_DIR
mkdir -p $ISO_MNT_DIR
mount -o loop $ISO_FILE $ISO_MNT_DIR
apt-get install yum
mkdir -p $RPM_ROOT_DIR
rpm --root $RPM_ROOT_DIR --initdb
mkdir -p $RPM_ROOT_DIR/etc/yum.repos.d
rm -rvf $RPM_ROOT_DIR/etc/yum.repos.d/*
add_local_repo
rpm --root $RPM_ROOT_DIR --import $ISO_MNT_DIR/RPM-GPG-KEY-CentOS-5
yum -y --installroot=$RPM_ROOT_DIR install centos-release
reset_repo
yum -y --installroot=$RPM_ROOT_DIR install yum
rm -rvf $RPM_ROOT_DIR/etc/yum.repos.d/*
echo Creating docker image $IMAGE_NAME from $RPM_ROOT_DIR
tar -C $RPM_ROOT_DIR/ -c . | docker import - $IMAGE_NAME
echo Creating docker image $IMAGE_NAEM success
echo Clearing tmp data
umount $ISO_MNT_DIR
rm -rf $ISO_MNT_DIR
rm -rf $RPM_ROOT_DIR
