FROM alpine:3.9
MAINTAINER lightimehpq@gmail.com

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add --no-cache qbittorrent-nox

RUN mkdir -p /qbittorrent /root/.config/qBittorrent/
COPY qBittorrent.conf /root/.config/qBittorrent/qBittorrent.conf
RUN mkdir -p /root/.local/share/data/qBittorrent/nova3/engines
COPY search-plugins/nova3/engines/* /root/.local/share/data/qBittorrent/nova3/engines/

COPY run.sh /
RUN chmod a+x /run.sh
ENTRYPOINT [ "/run.sh" ]
