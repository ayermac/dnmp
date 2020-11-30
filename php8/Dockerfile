FROM centos:8.2.2004

MAINTAINER chenchao

# Timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone

# 首先，安装阿里的 centos 仓库。（centos 8)
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo && \
rm -f  /etc/yum.repos.d/CentOS-centosplus.repo && \
rm -f  /etc/yum.repos.d/CentOS-PowerTools.repo && \
rm -f  /etc/yum.repos.d/CentOS-Extras.repo && \
rm -f  /etc/yum.repos.d/CentOS-AppStream.repo && \
dnf makecache && \
dnf repolist

# 安装阿里的 epel 仓库。（centos 8）
RUN dnf install -y epel-release && \
sed -i 's|^#baseurl=https://download.fedoraproject.org/pub|baseurl=https://mirrors.aliyun.com|' /etc/yum.repos.d/epel* && \
sed -i 's|^metalink|#metalink|' /etc/yum.repos.d/epel* && \
dnf makecache && \
dnf repolist

# 安装阿里的 remi 的仓库（centos 8)
RUN dnf install -y https://mirrors.aliyun.com/remi/enterprise/remi-release-8.rpm && \
sed -i  's/https*:\/\/rpms.remirepo.net/https:\/\/mirrors.aliyun.com\/remi/g'  /etc/yum.repos.d/remi* && \
sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/remi* && \
sed -i 's|^mirrorlist|#mirrorlist|' /etc/yum.repos.d/remi* && \
dnf makecache && \
dnf repolist

# 安装 php 8（centos 8）
RUN dnf install -y yum-utils && \
dnf install -y php80 php80-php-devel  php80-php-fpm  php80-php-mbstring php80-php-memcached php80-php-redis  php80-php-mysqlnd  php80-php-pdo  php80-php-bcmath php80-php-xml php80-php-gd php80-php-gmp php80-php-igbinary php80-php-imagick php80-php-pdo_mysql php80-php-posix php80-php-simplexml  php80-php-opcache php80-php-xsl php80-php-xmlwriter php80-php-xmlreader php80-php-swoole php80-php-zip  php80-php-yaml php80-php-uuid php80-php-pecl-mongodb php80-php-pecl-amqp php80-php-pecl-apcu

# 安装阿里的 composer 镜像源（centos 8）
RUN ln -s /usr/bin/php80 /usr/bin/php && \
curl -o /usr/local/bin/composer https://mirrors.aliyun.com/composer/composer.phar && \
chmod +x /usr/local/bin/composer && \
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

RUN groupadd -g 2000 httpd && \
useradd -g 2000 -u 2000 httpd && \
mkdir -p /opt/logs/php8 && chown httpd /opt/logs/php8

RUN rm -rf /etc/opt/remi/php80/php-fpm.d/www.conf
EXPOSE 9000

CMD ["/opt/remi/php80/root/usr/sbin/php-fpm", "--nodaemonize"]