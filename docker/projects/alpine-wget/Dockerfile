FROM alpine as build

ARG VER="1.99.2"
RUN mkdir /root/wget
WORKDIR /root/wget
ADD https://ftp.gnu.org/gnu/wget/wget2-$VER.tar.gz /root/wget
RUN tar zxvf wget2-$VER.tar.gz

RUN apk add gcc musl-dev make gnutls-dev libpsl-dev nghttp2-dev libbz2 zlib-dev xz-dev brotli-dev zstd-dev libidn-dev pcre-dev pcre2-dev libmicrohttpd-dev bzip2-dev gpgme-dev
WORKDIR /root/wget/wget2-$VER
RUN ./configure --disable-dependency-tracking --with-ssl=gnutls
RUN make
RUN make install

FROM alpine
COPY --from=build /usr/local /usr/local
#RUN apk add gnutls libbz2 nghttp2 zlib gpgme xz brotli zstd libidn pcre pcre2 libmicrohttpd
RUN apk add gnutls zstd-libs libpsl nghttp2-libs pcre pcre2 libidn libintl brotli xz-libs libbz2 ca-certificates gpgme
RUN ln -sf /usr/local/bin/wget2 /usr/bin/wget
ENTRYPOINT ["/usr/bin/wget"]
