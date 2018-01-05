# 项目文件说明
```
project/
├── c                    -- 保存配置的目录
│   ├── app.            -- 容器化的应用配置，用户一般只需要修改这个配置的文件即可
│   └── internal.       -- 内部配置，一些仅用于构建容器的配置保存在这里
├── ct                   -- 容器运行时的管理相关脚本
│   └── create-containe -- 创建容器
├── im                   -- 仅用于构建容器的内容
│   ├── build-image     -- 构建容器的脚本
│   └── Dockerf         -- 容器的 Dockerfile
└── README.              -- 项目说明
```

使用 build-image.sh 来构建项目主要有两个好处：
1. 不用记比较长的构建命令
2. 构建容器前，build-image 可以根据 conf 下的配置来修改 Dockerfile
