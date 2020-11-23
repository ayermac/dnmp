#!/bin/bash

# 告诉bash如果任何语句的执行结果不是true则应该退出
set -e

cd /opt/app/mysql57

if [ "$1" = 'start' ]; then
    exec set -- mysqld "$@"
    exec "$@"
fi

if [ "$1" = 'init' ]; then
    ./bin/mysqld --initialize-insecure --user=mysql
    #password=`cat /opt/app/mysql57/logs/error.log | grep -i 'temporary password' | awk -F ': ' '{print $2}'`
    #./bin/mysql -uroot -p${password} -e "alter user 'root'@'localhost' identified by '123456';GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456';"
fi

exec "$@"
