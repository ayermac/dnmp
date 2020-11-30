# Docker搭建的PHP开发环境
## 已有环境 Nginx+PHP7+PHP8+MySQL+Redis+Elasticsearch+mongodb+rabbitmq

## 目录结构
```
/
├─data
├─elasticsearch
├─mongo
├─mysql
│  ├─docker-entrypoint-initdb.d
│  └─etc
├─nginx
│  ├─conf
│  │  └─conf.d
│  └─source
├─php
│  ├─etc
│  │  └─php-fpm.d
│  └─source
├─php8
│  └─etc
│      └─php-fpm.d
├─rabbitmq
├─redis
│  ├─redis50
│  │  ├─db
│  │  ├─etc
│  │  └─var
│  └─source
└─www
    └─default
```
## 部署
```
> mv env.sample .env
# 构建镜像并启动
> docker-compose up -d
# 停止
> docker-compose stop
# 重启
> docker-compose restart
```

## Q&A
1. Q：构建镜像后容器启动不了怎么办？
   A：检查配置文件和目录权限是否正确。

