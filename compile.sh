#!/usr/bin/env bash

## Import software versions
source 'data/versions.sh'

## Import extra modules
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

## Download Zlib
wget -q https://zlib.net/$ZLIB.tar.gz
tar -xzf $ZLIB.tar.gz
rm -f $ZLIB.tar.gz

## Download PageSpeed module (optional)
if [ ${INSTALL_PAGESPEED} == "yes" ]; then
    wget -q https://github.com/pagespeed/ngx_pagespeed/archive/v${PAGESPEED_VERSION}-stable.zip
    unzip -qq v${PAGESPEED_VERSION}-stable.zip
    rm -f v${PAGESPEED_VERSION}-stable.zip
    cd ngx_pagespeed-${PAGESPEED_VERSION}-stable
    wget -q https://dl.google.com/dl/page-speed/psol/${PAGESPEED_VERSION}.tar.gz -O psol-${PAGESPEED_VERSION}.tar.gz
    tar xzf psol-${AGESPEED_VERSION}.tar.gz && rm -f psol-${AGESPEED_VERSION}.tar.gz
    cd ..
    PAGESPEED_MODULE="--add-module=../ngx_pagespeed-${PAGESPEED_VERSION}-stable"
else
    PAGESPEED_MODULE=""
fi

## Download NAXSI module (optional)
if [ ${INSTALL_NAXSI} == "yes" ]; then
    git clone https://github.com/nbs-system/naxsi.git --branch http2
    NAXSI_MODULE="--add-module=../naxsi/naxsi_src"
else
    NAXSI_MODULE=""
fi

## Configure, compile and install
cd $NGINX

./configure \
    ${NAXSI_MODULE} \
    ${PAGESPEED_MODULE} \
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

## Naxsi rules
if [ "${INSTALL_NAXSI}" == "yes" ]; then
    if [ ! -e "/etc/nginx/naxsi" ]; then
        mkdir -p /etc/nginx/naxsi
    fi

    # Download core rules
    if [ ! -e "/etc/nginx/naxsi/naxsi-core.rules" ]; then
        wget -q -O /etc/nginx/naxsi/naxsi-core.rules https://raw.githubusercontent.com/nbs-system/naxsi/master/naxsi_config/naxsi_core.rules
	fi

    # Download WordPress rules
    if [ ! -e "/etc/nginx/naxsi/naxsi-wordpress.rules" ]; then
        wget -q -O /etc/nginx/naxsi/naxsi-wordpress.rules https://raw.githubusercontent.com/nbs-system/naxsi-rules/master/wordpress.rules
	fi

    # Download Drupal rules
    if [ ! -e "/etc/nginx/naxsi/naxsi-drupal.rules" ]; then
        wget -q -O /etc/nginx/naxsi/naxsi-drupal.rules https://raw.githubusercontent.com/nbs-system/naxsi-rules/master/drupal.rules
    fi
fi

## Cleanup
cd ..
rm -rf $NGINX $OPENSSL $PCRE $ZLIB naxsi* ngx_pagespeed-*-stable
