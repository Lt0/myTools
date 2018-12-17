FROM alpine:3.7

RUN apk update && apk add --no-cache dnsmasq
RUN echo "conf-file=/etc/dnsmasq-custom.conf" >> /etc/dnsmasq.conf
COPY dnsmasq-upstream-servers.conf /etc/
COPY dnsmasq-custom.conf /etc/

COPY run.sh /sbin
RUN chmod a+x /sbin/run.sh

EXPOSE 53/tcp 53/udp
VOLUME ["/etc/dnsmasq.d/"]

ENTRYPOINT ["/sbin/run.sh"]
