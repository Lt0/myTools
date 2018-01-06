# 概述
给予 alpine 的 samba 服务

# 使用
## 配置 samba
根据需要修改 smb.conf，配置所需共享的目录和权限

## 构建容器
```
docker build -t samba .
```

## 运行容器
```
docker run --name=samba --restart=always -d -v hostSharePath:containerSharePath -p 139:139 -p 445:445 -it samba
```

# 管理
```
docker stop samba
  -- 停止容器
  
docker start samba
  -- 启动容器
  
docker attach samba
  -- 进入 samba 容器内的 /bin/sh，以方便调试
```


