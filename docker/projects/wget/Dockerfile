FROM alpine

RUN wget https://ftp.gnu.org/gnu/wget/wget-1.20.tar.gz && tar zxvf wget-1.20.tar.gz

RUN sed -i 's|^.*/alpine|http://172.0.5.75/alpine|g' /etc/apk/repositories
RUN apk update && apk add gcc g++ make m4 pkgconfig gnutls-dev

RUN cd wget-1.20/ && ./configure && make && make install

ENTRYPOINT ["/usr/local/bin/wget"]
