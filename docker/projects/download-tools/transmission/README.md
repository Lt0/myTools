# 概述
当前目录包含容器化的 transmission，自带 web ui，transmission 版本为 2.92。
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

## 创建容器
修改 conf/app.conf，配置下载路径，然后进入 ctrl 目录，执行 ctrl 下的 create_container.sh
```
cd ctrl
./create_container.sh
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
  
 docker rm -f transmission
  -- 删除容器
```

<br>

## 自动添加任务
将 torrent 文件复制到下载路径下的 auto_add 目录，tranmission 会自动添加该任务。

<br>

## 注意
- 配置界面中的下载路径始终显示为 /download，这个是容器内的路径，不要修改，如果要修改下载路径，去修改 conf/app.conf 中的下载路径，然后删除当前容器，重新创建容器。


<br>
<br>

# 客户端
tranmission 拥有丰富的客户端，可以通过配置使用指定的服务器作为后端。下面是一些个人用过的客户端，更多客户端查看官网说明：https://transmissionbt.com/resources/

## web ui
可以直接通过网页访问，transmission-daemon 自带，界面简陋但实用

## 浏览器插件
chrome 和 firefox 的插件都有 transmission 的前端，界面相对简陋，实用性也不错

## android
transmission-remote 可以直接从应用商店下载，界面很好，功能非常简单使用，基本不包括服务端的配置功能。

## 命令行
transmission-cli 是 linux 下的命令行工具，可以在没有界面的环境下使用

## 独立应用
transmission 有多个 linux 环境下的 GUI 前端
- transgui：功能完善，界面和传统的 linux 前端应用一样丑~ 支持 window，linux，mac os，参考：https://github.com/transmission-remote-gui/transgui
- transmission-remote-gtk：使用 gtk 开发的前端，功能完善，界面使用系统自带的 gtk 库，是否好看取决于系统自带的 gtk 版本，ubuntu 16.04 中自带的是 gtk 3.0，看起来效果还不错。
