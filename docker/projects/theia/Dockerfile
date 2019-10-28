FROM alpine AS base
MAINTAINER lightimehpq@gmail.com

# aliyun mirrors for speed up
RUN sed -i 's|^.*/alpine|http://mirrors.aliyun.com/alpine|g' /etc/apk/repositories
RUN apk update && apk add nodejs npm yarn python make cmake gcc g++
RUN mkdir /root/theia
WORKDIR /root/theia
COPY package.json /root/theia/package.json
RUN yarn 
RUN yarn theia build

RUN apk add go git

# using http proxy for access golang.org
ENV HTTP_PROXY=172.17.0.1:1080 HTTPS_PROXY=172.17.0.1:1080
RUN go get -v github.com/ramya-rao-a/go-outline
RUN go get -v golang.org/x/tools/cmd/guru
RUN go get -v github.com/rogpeppe/godef
ENV HTTP_PROXY= HTTPS_PROXY=
RUN echo '#!/bin/sh' > /usr/bin/godoc && echo "go doc $*" >> /usr/bin/godoc && chmod a+x /usr/bin/godoc

FROM alpine 
RUN sed -i 's|^.*/alpine|http://mirrors.aliyun.com/alpine|g' /etc/apk/repositories
RUN apk update && apk add nodejs npm yarn python make cmake gcc g++ go git
COPY --from=base /root/go/* /usr/bin/
COPY --from=base /root/theia /root/theia
RUN echo '#!/bin/sh' > /usr/bin/godoc && echo "go doc $*" >> /usr/bin/godoc && chmod a+x /usr/bin/godoc
WORKDIR /root/theia
