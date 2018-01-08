FROM alpine:3.7
MAINTAINER lightimehpq@gmail.com

RUN apk update && apk add --no-cache aria2 darkhttpd && mkdir -p /var/www/html && mkdir -p /opt/aria2/ && mkdir -p /var/log/darkhttpd/ && mkdir -p /var/log/aria2
ADD pkg/webui-aria2.tar.xz /var/www/html
ADD pkg/aria-ng.tar.xz /var/www/html
#RUN mv /var/www/html/webui-aria2/* /var/www/html/ && rm -rvf /var/www/html/webui-aria2
COPY run.sh /opt/aria2/
RUN chmod a+x /opt/aria2/run.sh
#COPY aria2c.conf /etc/
CMD [ "sh", "-c", "/opt/aria2/run.sh" ]
