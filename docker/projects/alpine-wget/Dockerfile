FROM alpine

ARG VER="1.99.2"
RUN mkdir /root/wget
WORKDIR /root/wget
ADD https://ftp.gnu.org/gnu/wget/wget2-$VER.tar.gz /root/wget
RUN tar zxvf wget2-$VER.tar.gz

RUN apk add gcc musl-dev make
WORKDIR /root/wget/wget2-$VER
RUN ./configure --disable-dependency-tracking
RUN make
RUN make install
RUN ln -sf /usr/local/bin/wget2 /usr/bin/wget
ENTRYPOINT ["/usr/bin/wget"]
