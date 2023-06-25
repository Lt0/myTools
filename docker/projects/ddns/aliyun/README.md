# Description

调用阿里云的 API 自动更新动态 IP 到指定域名

1. 通过环境变量传递参数
2. docker 镜像同时支持 amd64/arm64 架构的 linux 系统


参数说明

| 参数 | 必选 | 默认值 |
| - | - | - |
| DOMAIN_NAME | True | 无 |
| ACCESS_KEY_ID | True | 无 |
| ACCESS_KEY_SECRET | True | 无 |
| INTERVAL_MINUTE | False | 1 |
| EXTERNAL_IP_API | False | https://api.ipify.org/ |

关于直接使用 docker 镜像运行服务参考 start.sh 文件中的示例


## Build && push
```
docker buildx build --platform linux/amd64,linux/arm64 -t lightimehpq/aliddns:latest --push .
```

## Run
```
docker run --name aliddns \
--restart always \
-d \
-e DOMAIN_NAME=lt0.fun \
-e ACCESS_KEY_ID="xxx" \
-e ACCESS_KEY_SECRET="xxx" \
-v /etc/localtime:/etc/localtime \
-it lightimehpq/aliddns
```