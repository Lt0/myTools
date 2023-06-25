# Description

调用阿里云的 API 自动更新动态 IP 到指定域名

1. 通过 https://myexternalip.com/raw 获取当前的公网 IP
2. 通过环境变量传递参数: DOMAIN_NAME, ACCESS_KEY_ID, ACCESS_KEY_SECRET
3. 默认每分钟检查一次, 可以通过 INTERVAL_MINUTE 环境变量修改，单位是分钟


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