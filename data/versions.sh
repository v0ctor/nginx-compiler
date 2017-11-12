#!/usr/bin/env bash

## Software versions (you can edit this if there are newer versions)
## Updated: 2017-10-28

# Nginx
#NGINX_VERSION="1.13.5" # 2017-09-05 (mainline)
NGINX_VERSION="1.12.1" # 2017-07-11 (stable)

# OpenSSL
#OPENSSL_VERSION="tls1.3" # latest development version with TLS 1.3 support
#OPENSSL_VERSION="1.1.0f" # 2017-05-25 (stable)
OPENSSL_VERSION="1.0.2l" # 2017-05-25 (long term support)

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
PAGESPEED_VERSION="1.12.34.2" # 2017-06-20 (stable)
