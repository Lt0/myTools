# 概述
容器化的 deluge，在服务器上启动容器之后，可以指定给一个目录来进行下载，下载的数据保存在服务器上，可以在其它 PC 或手机等设备上通过 WEB 客户端或其它客户端软件进行控制。

deluge 本身支持 bt，磁链等下载，对下载的数据有较完善的管理，正在下载/下载完成/torrent 等都可以设置不同的放置路径，另外还可以设置一个目录来自动添加任务，只要将 torrent 文件复制到这个目录，deluge 可以自动添加该任务。


## 已测试环境
### 系统
- ubuntu 14.04

### 架构
- amd64

<br>
<br>

# 使用
## 构建镜像
```
cd image
./build-image.sh
```
- 依赖 alpine 3.7 作为源镜像
- 安装的是 edge/testing 下的 deluge

## 配置
修改 conf/app.conf，配置下载路径

## 首次启动容器
```
cd ctrl
./create_container.sh
```

## 管理
```
docker stop deluge
  -- 停止容器
  
docker start deluge
  -- 运行容器
  
docker attach deluge
  -- 进入容器内的 /bin/sh 以方便调试
```

## 路径说明
以下说明中用 $DOWNLOAD_PATH 表示用户自己设置的下载路径。

- $DOWNLOAD_PATH/incomplete： 正在下载的任务文件
- $DOWNLOAD_PATH/complete: 下载完成的任务文件
- $DOWNLOAD_PATH/torrent: 正在进行的 bt 任务的 torrent 文件
- $DOWNLOAD_PATH/auto_add: 自动添加 bt 任务的目录，将 torrent 文件复制到这个目录即可自动添加下载任务，添加成功后 torrent 文件会被移到 $DOWNLOAD_PATH/torrent 目录下。
- $DOWNLOAD_PATH/.deluge: deluge 的配置目录，包括 deluged，deluge-web 的配置、运行状态和日志等文件。

<br>
<br>

# 客户端
## WEB 客户端
容器内启动了 web 客户端，可以直接通过浏览器访问下面的地址：
```
IP:8112
```
- IP 指的是运行容器的物理机的 IP
- 登录密码是 vcube，可以在配置中修改，修改的是 web ui 的登录密码


## 客户端软件
如果是其它的客户端，比如 deluge-gtk 等，则需要在连接管理中添加一个服务器，服务器 IP 为 容器所在的物理机的 IP，端口为默认为的 58846，账号密码为：vcube/vcube

## 注意
- 客户端中看到的下载路径都是在 /download 下面，这是容器内部的下载路径，不要修改，如果要修改下载路径，修改 conf/app.conf 下的配置，然后删掉容器，按照首次启动的方式启动容器。
