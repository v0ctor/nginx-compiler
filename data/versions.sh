#!/usr/bin/env bash

## Software versions (you can edit this if there are newer versions)
## Updated: 2018-02-11

# Nginx
#NGINX_VERSION="1.13.8" # 2017-12-26 (mainline)
NGINX_VERSION="1.12.2" # 2017-10-17 (stable)

# OpenSSL
#OPENSSL_VERSION="tls1.3" # latest development version with TLS 1.3 support
#OPENSSL_VERSION="1.1.0g" # 2017-11-02 (stable)
OPENSSL_VERSION="1.0.2n" # 2017-12-07 (long term support)

# [About OpenSSL with TLSv1.3 support]
#
# It is a development version and it is based on the "draft18" branch.
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
