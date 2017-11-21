FROM nfv_build_server_base
MAINTAINER hepeiqin@casachina.com.cn

RUN mkdir -p /lib/modules && ln -s /usr/src/kernels/3.10.0-229.el7.x86_64 /lib/modules/3.10.0-229.el7.x86_64 && ln -s /usr/src/kernels/3.10.0-229.el7.x86_64 /lib/modules/3.10.0-229.el7.x86_64/build

RUN rm -rvf /etc/yum.repos.d/*
#COPY 163.repo /etc/yum.repos.d/163.repo
COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y gcc; exit 0

RUN mv /usr/bin/uname /usr/bin/uname_org
COPY hack-uname /usr/bin/uname
RUN chmod a+x /usr/bin/uname
