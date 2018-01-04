# 概述

当前目录下的工具是 syncthing 的容器化工具。
容器化后的 syncthing，使用 ctrl 下的 create_container.sh 来创建容器，容器名为 syncthing，同时自动创建 /syncthing 目录作为同步的根目录。

## 支持的系统
linux

## 支持的架构
amd64
arm64

<br>
<br>
# 构建容器
首先将 syncthing 的安装包(tar.gz) 文件复制到 pkg 目录下，然后执行下面的命令进行构建：
```
./build-image.sh
```
使用 alpine 作为基本镜像，生成的镜像名为 synchting。


<br>
<br>
# 使用
## 管理界面
直接通过 web 访问主机的 8384 端口即可。比如说本机 IP 为 192.168.2.3，则在浏览器上访问：
```
192.168.2.3:8384
```

<br>
## 容器管理
```
docker stop syncthing
docker start syncthing
docker attach syncthing
```


<br>
## 同步文件
所有同步的文件都在容器内的 /home/vcube 目录下，该目录会映射到物理机的 /syncthing 目录，所以用户要访问 syncthing 同步的文件的话，直接访问 /syncthing 即可。


<br>
## 日志
日志保存在容器内的 /var/log/syncthing/ 目录下，其中的 syncthing.log 是标准输出日志，syncthing_err.log 是错误输出日志。


<br>
## 调试
syncthing 容器中的 syncthing 应用在后台执行，要调试的话直接 attach 到改容器中即可进入 /bin/sh
