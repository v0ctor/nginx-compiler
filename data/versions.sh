#!/usr/bin/env bash

## Software versions (you can edit this if there are newer versions)
## Updated: 2018-07-03

# Nginx
#NGINX_VERSION="1.15.1" # 2018-07-03 (mainline)
NGINX_VERSION="1.14.0" # 2018-04-17 (stable)

# OpenSSL
#OPENSSL_VERSION="1.1.1-pre4" # 2018-04-03 (preview with TLS 1.3 support)
#OPENSSL_VERSION="1.1.0h" # 2018-03-27 (stable)
OPENSSL_VERSION="1.0.2o" # 2018-03-27 (long term support)

# [About OpenSSL 1.1.1]
#
# It is a preview version with TLS 1.3 support.
#
# Specific Nginx settings are required:
# - Add protocol "TLSv1.3" to the directive "ssl_protocols".
# - Add ciphers "TLS13-AES-128-GCM-SHA256 TLS13-AES-256-GCM-SHA384 TLS13-CHACHA20-POLY1305-SHA256" to the directive "ssl_ciphers".

# PCRE
PCRE_VERSION="8.41" # 2017-07-05 (old stable, latest supported by Nginx)

# Zlib
ZLIB_VERSION="1.2.11" # 2017-01-15 (stable)

# PageSpeed (module, optional)
PAGESPEED_VERSION="1.13.35.2" # 2018-02-05 (stable)
