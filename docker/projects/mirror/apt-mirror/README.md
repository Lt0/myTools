# 说明

这是一个容器化的本地 apt 镜像源，使用 apt-mirror 管理 apt 源，默认同步 x86 和 amd64 的 ubuntu trusty 版本软件源。
配置文件中自带了下列镜像源的配置：
- ubuntu trusty(x86/amd64)
- ubuntu xenial(armhf/arm64)
- debian jessie(armhf)

后面两个默认注释掉了，如果需要启用，则需要在 docker-data/mirror.list 文件中取消掉对应的配置注释，然后重新构建容器镜像并使用新的容器镜像重启服务。


<br>
<br>

# 构建
1. 确保 base/create.sh 的 MIRROR 指定的 url 是一个可用的源地址，然后构建 apt-mirror-base 基本镜像（如果本身已经有这个 docker image，则可以忽略这一步）:

```
cd base
./create.sh
```

<br>

2. 构建 apt-mirror 镜像，这个就是实际运行的容器化服务，在每天指定时间内同步，执行当前目录下的 create.sh 文件：
```
./create.sh
```

<br>
<br>

## 其它
### 数据目录
默认数据目录在 host 的 /var/spool/apt-mirror 如果要修改，可以直接修改 mgmt/start.sh，修改后需要停止服务再重新启动服务即可生效。

<br>

### 自定义时间
要自定时间，可以修改 mgmt/cmd.sh 文件中的时间，然后重新执行构建中的第二步。时间格式是 cron 的格式，第一个数字是分钟，第二个数字是小时。


<br>
<br>

# 使用
启动服务
```
cd mgmt
./start.sh
```
这个脚本执行后会启动容器，除非显式停止了容器，否则不需要重新执行该命令，即使是系统重启。

<br>

停止服务
```
cd mgmt
./stop.sh
```

<br>

调试
```
cd mgmt
./attach.sh
```
该命令会 attach 到当前正在运行的容器上，可以直接进入容器内的 bash 进行调试。
