#!/usr/bin/env bash

## Software versions (you can edit this if there are newer versions)
## Updated: 2017-10-13

# Nginx
#NGINX_VERSION="1.13.5" # 2017-09-05 (mainline)
NGINX_VERSION="1.12.1" # 2017-07-11 (stable)

# OpenSSL TLSv1.3 support
# Warning it is a development version and based into draft18 branch (latest is 1.1.1-dev)
# Add ciphers "TLS13-AES-128-GCM-SHA256 TLS13-AES-256-GCM-SHA384 TLS13-CHACHA20-POLY1305-SHA256"
# Add protocol "TLSv1.3"
#OPENSSL_VERSION="tls1.3"

# OpenSSL
#OPENSSL_VERSION="1.1.0f" # 2017-05-25 (stable)
OPENSSL_VERSION="1.0.2l" # 2017-05-25 (long term support)

# PCRE
PCRE_VERSION="8.41" # 2017-07-05 (old stable, latest supported by Nginx)

# Zlib
ZLIB_VERSION="1.2.11" # 2017-01-15 (stable)

# PageSpeed (module, optional)
PAGESPEED_VERSION="1.12.34.2" # 2017-06-20 (stable)
