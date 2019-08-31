# Docker搭建的PHP开发环境（Nginx+PHP+MySQL+Redis）

## 目录结构
```
/
├── mysql                       mysql目录
│   ├── etc                     配置文件目录
│   ├── shell                   初始化启动mysql，shell脚本
│   ├── source                  mysql源代码
│   ├── Dockerfile              mysql镜像构建文件
├── nginx                       nginx目录
│   ├── conf                    配置文件目录
│   ├── source                  nginx源代码
│   ├── Dockerfile              nginx镜像构建文件
├── php                         php目录
│   ├── etc                     配置文件目录
│   ├── source                  php源代码
│   ├── Dockerfile              php镜像构建文件
├── redis                       redis目录
│   ├── etc                     配置文件目录
│   ├── source                  redis源代码
│   ├── Dockerfile              redis镜像构建文件
├── env.smaple                  环境配置示例文件
└── www                         PHP代码目录
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

