FROM alpine:3.8
MAINTAINER lightimehpq@gmail.com

RUN apk update && apk add --no-cache openssh-client expect

WORKDIR /root

COPY run.sh /root/
COPY expose /root/
RUN chmod a+x /root/*.sh && chmod a+x /root/expose
ENTRYPOINT [ "/root/run.sh" ]
