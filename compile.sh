#!/usr/bin/env bash

## Import software versions
source 'data/versions.sh'

## Import extras modules
source 'data/extras.sh'

## File/directory names
NGINX="nginx-$NGINX_VERSION"
OPENSSL="openssl-$OPENSSL_VERSION"
PCRE="pcre-$PCRE_VERSION"
ZLIB="zlib-$ZLIB_VERSION"

## Go to the local source code directory
cd /usr/local/src

## Download Nginx
wget -q https://nginx.org/download/$NGINX.tar.gz
tar -xzf $NGINX.tar.gz
rm -f $NGINX.tar.gz

## Download OpenSSL
wget -q https://www.openssl.org/source/$OPENSSL.tar.gz
tar -xzf $OPENSSL.tar.gz
rm -f $OPENSSL.tar.gz

## Download PCRE
wget -q https://ftp.pcre.org/pub/pcre/$PCRE.tar.gz
tar -xzf $PCRE.tar.gz
rm -f $PCRE.tar.gz

## Download Zlib (there is no secure link, 😔)
wget -q http://zlib.net/$ZLIB.tar.gz
tar -xzf $ZLIB.tar.gz
rm -f $ZLIB.tar.gz

## Download module Naxsi with http2 supported (optional)
if [ ${INSTALL_NAXSI} == "yes" ]; then
    rm -Rf naxsi*
    git clone https://github.com/nbs-system/naxsi.git --branch http2
    ngx_naxsi_module="--add-module=../naxsi_src/ "
else
    ngx_naxsi_module=""
fi

## Configure, compile and install
cd $NGINX

./configure \
    ${ngx_naxsi_module} \
	--prefix=/usr/local/nginx \
	--sbin-path=/usr/sbin/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--pid-path=/var/run/nginx.pid \
	--error-log-path=/var/log/nginx/error.log \
	--http-log-path=/var/log/nginx/access.log \
	--user=nginx \
	--group=nginx \
	--lock-path=/var/run/nginx.lock \
	--modules-path=/usr/lib64/nginx/modules \
	--http-client-body-temp-path=/var/cache/nginx/client_temp \
	--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
	--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
	--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
	--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
	--with-compat \
	--with-file-aio \
	--with-threads \
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
	--with-mail \
	--with-mail_ssl_module \
	--with-openssl=/usr/local/src/$OPENSSL \
	--with-pcre=/usr/local/src/$PCRE \
	--with-pcre-jit \
	--with-stream \
	--with-stream_realip_module \
	--with-stream_ssl_module \
	--with-stream_ssl_preread_module \
	--with-zlib=/usr/local/src/$ZLIB \
	--with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic'

make -j $(nproc)
make install

## Cleanup
cd ..
rm -rf $NGINX $OPENSSL $PCRE $ZLIB naxsi*
