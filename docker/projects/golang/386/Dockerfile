FROM lightimehpq/xenial-386
MAINTAINER lightimehpq@gmail.com

RUN apt-get update && apt-get install -y gcc-arm-linux-gnueabihf && rm -rvf /var/cache/apt/*

ADD go*386.tar.gz /opt
RUN mkdir -p /golang/src /golang/bin /golang/pkg
ENV GOROOT=/opt/go
ENV GOPATH=/golang
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

COPY run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh
CMD [ "/usr/local/bin/run.sh" ]
