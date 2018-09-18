FROM alpine:3.7
MAINTAINER hepeiqin
RUN apk update && apk add --no-cache samba
COPY smb.conf /etc/samba/smb.conf
COPY setsamba.sh /root/setsamba.sh
COPY start_samba.sh /root/start_samba.sh
RUN cd /root && ./setsamba.sh
CMD /root/start_samba.sh
