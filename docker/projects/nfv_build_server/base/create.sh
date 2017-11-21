#!/bin/sh
#MAINTAINER hepeiqin@casachina.com.cn
IMAGE_NAME=nfv_build_server_base
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
echo "
[rhel71le]
baseurl=file://$ISO_MNT_DIR
enabled=1
" > $RPM_ROOT_DIR/etc/yum.repos.d/rhel71le.repo
rpm --root $RPM_ROOT_DIR --import $ISO_MNT_DIR/RPM-GPG-KEY-redhat-*
yum -y --installroot=$RPM_ROOT_DIR install yum net-tools wget bc vim findutils tcpdump diffutil util-linux iputils bc diffutil gcc gcc-c++ libevent gettext which patch libtool glib2-devel flex flex-devel.i686 flex-devel bison bison-devel.i686 bison-devel zlib-devel.i686 zlib-devel zlib.i686 zlib xterm cscope dos2unix texinfo glibc.i686 glibc glibc-devel glibc-devel.i686 cmake make automake autoconf libffi-devel ncurses-devel bzip2 rsync kernel-devel-3.10.0-229.el7.x86_64 unzip libudev-devel boost-devel
echo Creating docker image $IMAGE_NAME from $RPM_ROOT_DIR
tar -C $RPM_ROOT_DIR/ -c . | docker import - $IMAGE_NAME
echo Creating docker image $IMAGE_NAEM success
echo Clearing tmp data
umount $ISO_MNT_DIR
rm -rf $ISO_MNT_DIR
rm -rf $RPM_ROOT_DIR
