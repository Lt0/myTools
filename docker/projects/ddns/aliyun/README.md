# Description

调用阿里云的 API 自动更新动态 IP 到指定域名

1. 通过环境变量传递参数
2. docker 镜像同时支持 amd64/arm64 架构的 linux 系统
3. 支持多实例, 每个实例维护一条解析记录, 例如可以起一个实例来维护 lt0.info, 再起一个实例来维护 *.lt0.info


参数说明

| 参数 | 必选 | 默认值 | 说明 |
| - | - | - | - | 
| DOMAIN_NAME | True | 无 | 要配置的域名, 例如 lt0.fun
| ACCESS_KEY_ID | True | 无 | 阿里云的 Access Key ID
| ACCESS_KEY_SECRET | True | 无 | 阿里云的 Access Key Secret
| INTERVAL_MINUTE | False | 1 | 检查间隔，单位是分钟
| EXTERNAL_IP_API | False | "https://api.ipify.org/" | 获取外部 IP 的 API
| RR | False | "@" | 主机记录, e.g: "@", "www", "*", "abc.def"
| RESOLVE_TYPE | False | "A" | 记录类型, e.g: "A", "CNAME", "AAA", "TXT"...
| LINE | False | "default" | 阿里云 DNS 预定义的解析线路，如默认(default)、联通(unicom)、移动(cmcc)、电信(ctc)、境内教育网(edu)、搜索引擎等等

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