###Dockerfile文件目录执行构建命令
    docker build -t dnmp_mysql:5.7.22 .
###初始化mysql
    #shell形式创建镜像容器
    # -v 参数“:”前为母机路径，后面为容器路径
    docker run -tid -v ./etc/my.cnf:/opt/app/mysql57/etc/my.cnf -v ./tmp/:/opt/app/mysql57/tmp/ -v ./var/:/opt/app/mysql57/var/ -v ./logs/:/opt/app/mysql57/logs/ dnmp_mysql:5.7.22 /bin/bash
    #进入容器
    docker exec -it 容器ID(上边命令创建的容器) /bin/bash
    #执行mysql初始化命令
    ./mysqld  --initialize --user=mysql
    #退出容器并删除容器
    docker rm 容器ID
### 创建mysql容器
    #创建容器并后台运行
    docker run -d --name xq_mysql -p 3307:3306 -v ./etc/my.cnf:/opt/app/mysql57/etc/my.cnf -v ./tmp/:/opt/app/mysql57/tmp/ -v ./var/:/opt/app/mysql57/var/ -v ./logs/:/opt/app/mysql57/logs/ mysql:5.7.22
    #进入容器修改MySQL密码
    docker exec -it dnmp_mysql bash
    #初始密码在/opt/app/mysql57/logs/error.log中
    ./bin/mysql -uroot -p
    #进入mysql
    alter user 'root'@'localhost' identified by '123456';
    #设置外网可访问权限
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456';
    #退出容器
### 客户端链接mysql
    navicat配置mysql相关信息进行连接测试。
