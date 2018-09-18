# 概述 
基于 alpine:3.7 封装的 samba 服务镜像

# 使用
执行下面命令查看具体的使用方法: 
```
docker run --rm samba
```

# 日常管理
```
docker stop samba
  -- 停止容器
  
docker start samba
  -- 启动容器
  
docker attach samba
  -- 进入 samba 容器内的 /bin/sh，以方便调试
```


