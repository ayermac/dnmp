FROM centos:7.8.2003
MAINTAINER chenchao

# set timezome
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG NGINX_VERSION
ENV OPENSSL_VERSION openssl-1.0.2s

COPY ./source/nginx-$NGINX_VERSION.tar.gz /tmp/nginx.tar.gz
COPY ./source/ngx_openresty-master.tar.gz /tmp/ngx_openresty-master.tar.gz
COPY ./source/perl-5.28.0.tar.gz /tmp/perl-5.28.0.tar.gz
COPY ./source/resty.tar.gz /tmp/resty.tar.gz
COPY ./source/${OPENSSL_VERSION}.tar.gz /tmp/${OPENSSL_VERSION}.tar.gz

# Install LUAJIT
RUN yum -y install gcc make pcre-devel zlib-devel wget zip unzip patch bzip2 net-tools \
    perl-dev \
    curl \
    gd-dev \
    luajit-dev \
    && groupadd -f httpd \
    && groupadd -f docker \
    && useradd -d /home/httpd -s /bin/bash -g httpd -G docker httpd \
    && tar -zxvf /tmp/ngx_openresty-master.tar.gz -C /tmp/ \
    && rm -rf /tmp/ngx_openresty-master.tar.gz \
    && cd /tmp/ngx_openresty-master/bundle/LuaJIT-2.1-20170808 \
    && make \
    && make install \
    && tar -zxvf /tmp/perl-5.28.0.tar.gz -C /tmp/ \
    && rm -f perl-5.28.0.tar.gz \
    && cd /tmp/perl-5.28.0 \
    && ./Configure -des -Dprefix=$HOME/localperl \
    && make \
    && make install \
    && ln -s $HOME/localperl/bin/perl /usr/bin/perl \
    && rm -rf /tmp/perl-5.28.0 \
    && tar xf /tmp/${OPENSSL_VERSION}.tar.gz -C /tmp/ \
    && rm -f /tmp/${OPENSSL_VERSION}.tar.gz \
    && mkdir -p /opt/app \
    && mkdir -p /opt/case

RUN CONFIG="\
        --prefix=/opt/app/nginx \
        --sbin-path=/opt/app/nginx/sbin/nginx \
        --modules-path=/opt/app/nginx/modules \
        --conf-path=/opt/app/nginx/conf/nginx.conf \
        --http-client-body-temp-path=/opt/app/nginx/cache/client_temp \
        --http-proxy-temp-path=/opt/app/nginx/cache/proxy_temp \
        --http-fastcgi-temp-path=/opt/app/nginx/cache/fastcgi_temp \
        --http-uwsgi-temp-path=/opt/app/nginx/cache/uwsgi_temp \
        --http-scgi-temp-path=/opt/app/nginx/cache/scgi_temp \
        --with-compat \
        --with-file-aio \
        --with-threads \
        --user=httpd \
        --group=httpd \
        --with-http_addition_module \
        --with-http_auth_request_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_mp4_module \
        --with-http_random_index_module \
        --with-http_realip_module \
        --with-http_secure_link_module \
        --with-http_slice_module \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --with-http_sub_module \
        --with-http_v2_module \
        --with-stream \
        --with-stream_ssl_module \
        --with-openssl=/tmp/${OPENSSL_VERSION}/ \
        --with-ld-opt="-Wl,-rpath,/usr/local/lib" \
        --with-debug \
        --add-module=/tmp/ngx_openresty-master/bundle/ngx_devel_kit-0.3.0 \
        --add-module=/tmp/ngx_openresty-master/bundle/iconv-nginx-module-0.14 \
        --add-module=/tmp/ngx_openresty-master/bundle/echo-nginx-module-0.61 \
        --add-module=/tmp/ngx_openresty-master/bundle/xss-nginx-module-0.05 \
        --add-module=/tmp/ngx_openresty-master/bundle/ngx_coolkit-0.2rc3 \
        --add-module=/tmp/ngx_openresty-master/bundle/set-misc-nginx-module-0.31 \
        --add-module=/tmp/ngx_openresty-master/bundle/form-input-nginx-module-0.12 \
        --add-module=/tmp/ngx_openresty-master/bundle/encrypted-session-nginx-module-0.06 \
        --add-module=/tmp/ngx_openresty-master/bundle/srcache-nginx-module-0.31 \
        --add-module=/tmp/ngx_openresty-master/bundle/ngx_lua-0.10.10 \
        --add-module=/tmp/ngx_openresty-master/bundle/ngx_lua_upstream-0.07 \
        --add-module=/tmp/ngx_openresty-master/bundle/headers-more-nginx-module-0.32 \
        --add-module=/tmp/ngx_openresty-master/bundle/array-var-nginx-module-0.05 \
        --add-module=/tmp/ngx_openresty-master/bundle/memc-nginx-module-0.18 \
        --add-module=/tmp/ngx_openresty-master/bundle/redis-nginx-module-0.3.7 \
        --add-module=/tmp/ngx_openresty-master/bundle/rds-json-nginx-module-0.14 \
        --add-module=/tmp/ngx_openresty-master/bundle/rds-csv-nginx-module-0.07 \
    " \
    && export LUAJIT_LIB=/usr/local/lib \
    && export LUAJIT_INC=/usr/local/include/luajit-2.1 \
    && mkdir -p /opt/app/nginx/conf/conf.d \
    && mkdir -p /opt/app/nginx/html \
    && mkdir -p /opt/app/nginx/cache \
    && mkdir -p /opt/app/nginx/logs \
    && tar -zxC /opt/app -f /tmp/nginx.tar.gz \
    && rm -f /tmp/nginx.tar.gz \
    && cd /opt/app/nginx-$NGINX_VERSION \
    && ./configure $CONFIG \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && rm -rf /etc/nginx/html/ \
    && install -m644 html/index.html /opt/app/nginx/html/ \
    && install -m644 html/50x.html /opt/app/nginx/html/ \
    && strip /opt/app/nginx/sbin/nginx* \
    && ln -s /opt/app/nginx/sbin/nginx /usr/bin/ \
    && ln -s /usr/local/lib/libluajit-5.1.so.2 /lib64/ \
    && yum install -y .gettext gettext \
    && cd /tmp/ngx_openresty-master/bundle/lua-cjson-2.1.0.5 \
    && make \
    && mkdir -p /usr/local/lib/lua/5.1 \
    && cp ./cjson.so /usr/local/lib/lua/5.1 \
    && mkdir -p /opt/app/nginx/lualib \
    && tar -zxC /opt/app/nginx/lualib -f /tmp/resty.tar.gz \
    && rm -rf /tmp/resty.tar.gz \
    && rm -rf /opt/app/nginx-$NGINX_VERSION \
    && rm -rf /tmp/ngx_openresty-master \
    && chmod 777 /opt/app/nginx/logs


# fix chinese encode
RUN yum -y install kde-l10n-Chinese telnet \
    && yum -y reinstall glibc-common \
    && yum clean all \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL "zh_CN.UTF-8"

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
