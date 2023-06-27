# Description

调用阿里云的 API 自动更新动态 IP 到指定域名

1. 支持多域名，每个域名支持多条解析记录
2. docker 镜像同时支持 amd64/arm64 架构的 linux 系统


## Config
默认配置文件路径 /etc/aliddns.yaml
可以通过 -c /path/to/your/config 指定

配置文件示例见 aliddns.yaml 文件
 

## Build && push
```
docker buildx build --platform linux/amd64,linux/arm64 -t lightimehpq/aliddns:latest --push .
```

## Run
```
docker run --name aliddns \
    --restart always \
    -d \
    -v $PWD/aliddns.yaml:/etc/aliddns.yaml \
    -v /etc/localtime:/etc/localtime \
    -it lightimehpq/aliddns
```