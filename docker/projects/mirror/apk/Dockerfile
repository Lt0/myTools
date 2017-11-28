FROM alpine
MAINTAINER lightimehpq@gmail.com.cn

RUN apk update && apk add --no-cache lighttpd rsync && rm -rvf /var/cache/apk/*
COPY alpine-mirror /etc/periodic/daily/alpine-mirror
RUN chmod +x /etc/periodic/daily/alpine-mirror

COPY syncd.conf.part /root/syncd.conf.part
RUN cat /root/syncd.conf.part >> /etc/rsyncd.conf
RUN cat /etc/rsyncd.conf

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh
CMD /root/run.sh

