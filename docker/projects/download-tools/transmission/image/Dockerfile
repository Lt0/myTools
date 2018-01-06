FROM alpine:3.7
MAINTAINER lightimehpq@gmail.com
RUN apk update && apk add --no-cache transmission-daemon
RUN mkdir -p /var/log/transmission && mkdir -p /opt/transmission && mkdir -p /download/incomplete
ADD cmd.sh /opt/transmission/
ADD settings.json /opt/transmission/conf/
RUN chmod a+x /opt/transmission/cmd.sh && chown transmission:transmission /var/log/transmission && chown -R transmission:transmission /download
CMD [ "sh", "-c", "/opt/transmission/cmd.sh" ]
