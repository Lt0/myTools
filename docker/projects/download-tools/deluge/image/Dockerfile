FROM alpine:3.7
MAINTAINER lightimehpq@gmail.com

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && apk update && apk add --no-cache deluge py2-pip && pip install incremental constantly service_identity
RUN pip install automat mako
RUN mkdir -p /download/.deluge/ && mkdir -p /opt/deluge/ 
COPY web.conf core.conf auth /download/.deluge/
COPY run.sh /opt/deluge/
RUN chmod a+x /opt/deluge/run.sh
CMD [ "sh", "-c", "/opt/deluge/run.sh" ]
