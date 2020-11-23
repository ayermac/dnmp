FROM centos:7.8.2003
MAINTAINER chenchao

ENV INSTALL_DIR /opt/app/redis50

RUN yum -y install gcc gcc-c++ make \
    && yum clean all -y

# Timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone

ARG REDIS_VERSION

# Mysql
ADD source/redis-${REDIS_VERSION}.tar.gz /tmp/
RUN cd /tmp/redis-${REDIS_VERSION} \
    && make && make install PREFIX=${INSTALL_DIR} \
    && mkdir ${INSTALL_DIR}/{etc,var,logs,db_6379} \
    && rm -r /tmp/redis-${REDIS_VERSION}

# workdir
WORKDIR ${INSTALL_DIR}

EXPOSE 6379

CMD ["./bin/redis-server","./etc/redis_6379.conf"]