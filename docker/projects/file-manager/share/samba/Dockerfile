FROM rhel:7.1
MAINTAINER hepeiqin
COPY CentOS-Base-aliyun.repo /etc/yum.repos.d/
RUN rm -rvf /etc/yum.repos.d/rhel71le.repo && yum install -y samba samba-client; echo "install operation finish"
COPY smb.conf /etc/samba/smb.conf
COPY setsamba.sh /root/setsamba.sh
COPY start_samba.sh /root/start_samba.sh
RUN cd /root && ./setsamba.sh
CMD /root/start_samba.sh
