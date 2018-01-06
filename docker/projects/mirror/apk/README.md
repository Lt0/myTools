# 说明
当前目录包含容器化的 apk 软件远同步功能，只负责同步，不提供 http 服务

- alpine 仓库版本：v3.7
- 同步方式：rsync
- 同步时间：每天 2:00


# 使用
## 构建容器
```
cd image
./build-image.sh
```
以来 alpine v3.7 作为源镜像
构建的容器镜像名为 apk-mirror

## 启动容器
```
docker run --name apk-mirror --restart=always -d -v your-path-to-save-mirror:/apk-mirror -it apk-mirror
```

