FROM alpine
MAINTAINER lightimehpq@gmail.com.cn


RUN apk update && apk add --no-cache rsync && rm -rvf /var/cache/apk/*
COPY alpine-mirror /etc/periodic/daily/alpine-mirror
COPY pickup /root/
RUN chmod +x /etc/periodic/daily/alpine-mirror && mkdir /apk-mirror

COPY syncd.conf.part /root/syncd.conf.part
RUN cat /root/syncd.conf.part >> /etc/rsyncd.conf

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh
CMD /root/run.sh

