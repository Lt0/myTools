FROM nfv_build_server_base
MAINTAINER hepeiqin@casachina.com.cn

RUN mkdir -p /lib/modules && ln -s /usr/src/kernels/3.10.0-229.el7.x86_64 /lib/modules/3.10.0-229.el7.x86_64 && ln -s /usr/src/kernels/3.10.0-229.el7.x86_64 /lib/modules/3.10.0-229.el7.x86_64/build

RUN rm -rvf /etc/yum.repos.d/*
#COPY 163.repo /etc/yum.repos.d/163.repo
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://172.0.5.75/centos/7/aliyun/CentOS-Base.repo
RUN yum install -y gcc-4.8.5; exit 0
RUN yum install -y centos-release-scl; exit 0
RUN yum install -y devtoolset-3-gcc devtoolset-3-libasan-devel devtoolset-3-gcc-c++; exit 0

RUN mv /usr/bin/uname /usr/bin/uname_org
COPY hack-uname /usr/bin/uname
RUN chmod a+x /usr/bin/uname
