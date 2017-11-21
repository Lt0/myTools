FROM centos:7
MAINTAINER hpq

RUN rm -rvf /etc/yum.repos.d/* && curl -o /etc/yum.repos.d/private.repo http://172.0.5.75/centos/7/private.repo
RUN yum install -y yum-utils createrepo crontabs
RUN mv /etc/yum.repos.d/private.repo /etc/yum.repos.d/private.repo.backup
COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
#RUN yum makecache

RUN rm -rvf /etc/localtime; ln -s /usr/share/zoneinfo/Singapore /etc/localtime 

RUN mkdir -p /repository/log
COPY cmd.sh sync.sh /root/
RUN chmod a+x /root/cmd.sh && chmod a+x /root/sync.sh
CMD [ "sh", "-c", "/root/cmd.sh" ]
