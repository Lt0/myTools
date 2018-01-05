FROM alpine
MAINTAINER lightimehpq@gmail.com

RUN apk update && apk add --no-cache aria2 darkhttpd && mkdir -p /var/www/html && mkdir -p /opt/aria2/ && mkdir -p /var/log/darkhttpd/
ADD pkg/webui-aria2.tar.xz /var/www/html
COPY run.sh /opt/aria2/
CMD [ "sh", "-c", "/opt/aria2/run.sh" ]
