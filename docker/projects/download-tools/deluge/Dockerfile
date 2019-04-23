FROM alpine:3.9
MAINTAINER lightimehpq@gmail.com

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add --no-cache deluge py2-pip && pip install incremental constantly service_identity

RUN mkdir -p /deluge && mkdir -p /opt/deluge/
COPY web.conf core.conf hostlist.conf.1.2 /root/.config/deluge/
COPY run.sh /opt/deluge/
RUN chmod a+x /opt/deluge/run.sh
ENTRYPOINT [ "/opt/deluge/run.sh" ]
