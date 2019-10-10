FROM alpine
MAINTAINER lightimehpq@gmail.com

RUN sed -i 's|^.*/alpine|http://mirrors.aliyun.com/alpine|g' /etc/apk/repositories
RUN apk update && apk add nodejs npm yarn python make cmake gcc g++
RUN mkdir /root/theia
WORKDIR /root/theia
COPY package.json /root/theia/package.json
RUN yarn 
RUN yarn theia build
