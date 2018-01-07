# 说明
容器中包含了 aria2 命令行工具和两个 web 前端：aria-ng 和 webui-aria2。容器启动之后可以直接通过网页进行控制。

aria2 本身支持普通 url，磁链和 bt 下载，支持断点续传，通过文件支持多链路下载等功能。

<br>


# 构建容器
```
cd image
./build-image.sh
```
使用 alpine v3.7 作为底包
生成的 docker image 名为 aria2

<br>


# 使用
## 启动容器
运行前需要指定下载路径，将下面的命令中的 your-download-path 修改为你的下载路径
```
docker run --name=aria2 -d -v your-download-path:/download -p 6800:6800 -p 6789:80 -it aria2
```

<br>

## 控制界面
通过浏览器访问 IP:6789 即可访问 aria-ng 前端，进行控制 aria2，IP 为容器所在的 host 的 IP，比如容器运行的设备 IP 为 192.168.2.3，则在浏览器访问：192.168.2.3:6789

如果要访问 webui-aria2，则访问 IP:6789/webui-aria2

如果使用的是客户端软件，则在客户端配置 host 为 IP:6800。

<br>


# 管理容器
```
docker stop aria2
  -- 停止 aria2
  
docker start aria2
  -- 启动 aria2
  
docker attach aria2
  -- 进入容器内的 /bin/sh，以方便调试
```

<br>


# 日志
aria2 的日志保存在容器内的 /var/log/aria2/aria2.log

web 服务的日志保存在容器内的 /var/log/darkhttpd/darkhttpd.log

<br>

# 注意
- ui 中的配置界面显示的下载路径为 /download，这个是容器内的路径
- 删除容器会导致配置和当前下载进度全部失效，但只要文件没有删，重新加载下载任务后可以恢复进度并继续下载

<br>

# 客户端
aria2 客户端相对较少，下面是一些客户端
## web ui
- aria-ng：一个较新的 web 前端，界面很好，功能分类也很整齐，是容器内的默认管理前端，推荐使用。改前端来源于：https://github.com/mayswind/AriaNg
- webui-aria2：最古老的 web 前端，界面比较原始，容器内自带，但访问路径为：IP:PORT/webui-aria2
- yaaw：相对较新，但界面和功能过于简陋

## android
- Aria2App：android 下目前相对完善的客户端，界面一般，通过浏览器下载文件的时候选择它来下载的话可以直接向服务器添加下载任务。
- aria2-remote：功能极其简单，界面比较简洁 —— 如果没有广告的话~~~
- aria2 remote：功能极其简单，界面简洁，没有广告，但只能添加链接任务。
