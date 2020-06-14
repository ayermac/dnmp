FROM centos:7.4.1708
MAINTAINER chenchao

ENV INSTALL_DIR /opt/app/redis40

RUN yum -y install gcc gcc-c++ make \
    && yum clean all -y

# Timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone

# Mysql
ADD source/redis-4.0.10.tar.gz /tmp/
RUN cd /tmp/redis-4.0.10 \
    && make && make install PREFIX=${INSTALL_DIR} \
    && mkdir ${INSTALL_DIR}/{etc,var,logs,db_6379} \
    && rm -r /tmp/redis-4.0.10

# workdir
WORKDIR ${INSTALL_DIR}

EXPOSE 6379

CMD ["./bin/redis-server","./etc/redis_6379.conf"]