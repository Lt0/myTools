FROM lightimehpq/xenial-amd64
MAINTAINER lightimehpq@gmail.com

RUN apt-get update && apt-get install -y gcc-aarch64-linux-gnu && rm -rvf /var/cache/apt/*

ADD go*.tar.gz /opt
RUN mkdir -p /go/src /go/bin /go/pkg
ENV GOROOT=/opt/go
ENV GOPATH=/go
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

COPY run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh
CMD [ "/usr/local/bin/run.sh" ]
