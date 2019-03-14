FROM alpine:v3.9
MAINTAINER lightimehpq@gmail.com

RUN apk update && apk add --no-cache rsync openrc darkhttpd && rm -rvf /var/cache/apk/*

COPY alpine-mirror-size.sh /
RUN chmod a+x /alpine-mirror-size.sh

COPY alpine-mirror /etc/periodic/daily/
RUN chmod a+x /etc/periodic/daily/alpine-mirror && mkdir /mirror
#COPY alpine-mirror /etc/periodic/15min/
#RUN chmod a+x /etc/periodic/15min/alpine-mirror && mkdir /mirror

# setup alpine-mirror configuration
COPY alpine-mirror.conf /etc/
COPY syncd.conf.part /root/syncd.conf.part
RUN cat /root/syncd.conf.part >> /etc/rsyncd.conf

COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
