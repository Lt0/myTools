# 说明
这是一个容器化的本地 yum 镜像源，自动从 mirrors.aliyun.com 同步 centos 7 版本镜像源。

<br>
<br>

# 构建
1. 确保 base/CentOS-7-x86_64-Everything-1611.iso 指向的 centos 7 iso 路径正确，然后构建 centos 7 基本镜像（如果本身已经有 centos:7 这个 docker image，则可以忽略这一步）:
```
cd base
./create.sh
```

<br>

2. 构建 repo-centos-7 镜像，这个就是实际运行的容器化服务，在每天指定时间内同步：
```
cd ..
./create.sh
```

<br>
<br>

## 其它
### 数据目录
默认数据目录在 /media/hd2/mirrors/reposync/centos/7/，如果要修改，可以直接修改 start.sh，修改后需要停止服务再重新启动服务即可生效。

<br>

### 自定义时间
要自定时间，可以修改 cmd.sh 文件中的时间，然后重新执行构建中的第二步。时间格式是 cron 的格式，第一个数字是分钟，第二个数字是小时。


<br>
<br>

# 使用
启动服务
```
./start.sh
```
这个脚本执行后会启动容器，除非显式停止了容器，否则不需要重新执行该命令，即使是系统重启。

<br>

停止服务
```
docker rm -f repo-centos-7
```

<br>

调试
```
docker attach repo-centos-7
```
attach 到 repo-centos-7 容器即可直接进入容器内的 bash 进行调试。
