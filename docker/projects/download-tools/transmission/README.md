# 概述
当前目录包含容器化的 transmission，自带 web ui。
transmission 本身支持 bt 和磁链下载，不支持普通 url 下载。


<br>
<br>

# 使用
## 构建镜像
```
cd image
./build-image.sh
```
- 依赖 alpine:3.7 作为基础镜像
- 默认构建的容器镜像名为 transmission

<br>

## 运行容器
修改 host-download-path 为下载路径
```
docker run --name=transmission -d -it --restart=always -v host-download-path:/download -p 9091:9091 transmission
```

<br>

## 访问
浏览器访问 IP:9091，IP 指的是运行容器的设备的 IP

<br>

## 管理
```
docker stop transmission
  -- 停止正在运行的容器
  
docker start transmission
  -- 重新启动被停止的容器
  
docker attach transmission
  -- 进入容器内进行调试
```

<br>
<br>

# 注意

- 删除容器之后所有的配置都会失效
- 配置界面中的下载路径始终显示为 /download，这个是容器内的路径
