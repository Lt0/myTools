FROM centos:7
MAINTAINER lightimehpq@gmail.com

RUN yum install -y yum-utils

COPY entrypoint.sh /
WORKDIR /root
ENTRYPOINT [ "/entrypoint.sh" ]
