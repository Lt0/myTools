FROM alpine:3.7
MAINTAINER lightimehpq@gmail.com

RUN apk update && apk add --no-cache openrc nfs-utils

COPY exports /etc/exports
COPY run.sh /root/run.sh
RUN chmod a+x /root/*.sh

RUN rc-update add nfs && rc-status

ENTRYPOINT [ "/root/run.sh" ]
