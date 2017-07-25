# Nginx compiler

Build and install [Nginx](https://nginx.org) on any UNIX system with the latest version of [OpenSSL](https://www.openssl.org/) to support [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation), and therefore [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2).

## Features
* Builds and installs Nginx with its dependencies in a single step.
* Uses the latest stable/LTS versions of the software.
* Can be used on any UNIX system with the corresponding dependencies.
* Is transparent and secure, by not forcing the system administrator to rely on packages built and distributed by unofficial sources.

## *To use, or not to use*
Below are shown the **GNU/Linux distributions** for which the official Nginx packages come with old versions of OpenSSL **that do not support ALPN**. If your operating system and version are listed below, use this utility. Otherwise it is preferable to use the [official Nginx packages](https://nginx.org/en/linux_packages.html) through your distribution's package manager.

* Debian
* RHEL / CentOS
* Ubuntu 15.10 and earlier
* Any other for which there is no [official package](https://nginx.org/en/linux_packages.html)

> Debian distributes Nginx with OpenSSL 1.0.2k through *[jessie-backports](https://packages.debian.org/jessie-backports/nginx)*, but backport packages are provided without any warranty and they should only be used for testing purposes.

## Dependencies
This utility requires `wget` and essential building tools like the `make` command and the GCC compiler. To install the necessary packages, go to the `dependencies` directory and run the script corresponding to your GNU/Linux distribution or family. For example:
```Shell
sh dependencies/debian-ubuntu.sh
```

The minimum OpenSSL version that supports ALPN is 1.0.2. You can edit the software versions that are going to be compiled by editing the `data/versions.sh` file. By default, the utility will build the latest stable version of Nginx with the latest supported stable/LTS versions of OpenSSL, PCRE and Zlib.

## Usage
Run the main script and Nginx will be automatically compiled and installed in your system.

```Shell
sh compile.sh
```

If you want to build the latest mainline Nginx version instead of the stable one, comment and uncomment the corresponding lines of the `data/versions.sh` file. Do the same if you want to use the latest stable OpenSSL version instead of the LTS (long term support) one.

## Modules

There are extra modules that you can optionally install by editing the file `data/modules.sh`.

### Pagespeed

[Pagespeed](https://github.com/pagespeed/ngx_pagespeed) is an open-source module created by Google to help make the web faster by rewriting web pages to reduce latency and bandwidth.

### Naxsi

[Naxsi](https://www.nbs-system.com/securite-informatique/outils-securite-informatique-open-source/naxsi/) is a web application firewall based on sets of rules. To enable it, edit the file `data/modules.sh` and set the `INSTALL_NAXSI` variable to `yes`.

Settings example for `nginx.conf`:
```Nginx
http {
    include /etc/nginx/naxsi/naxsi-core.rules;
}
```

Settings example for `conf.d/*.conf`:
```Nginx
location / {
    try_files $uri $uri/ /index.php?$query_string;
    SecRulesEnabled;
    CheckRule "$SQL >= 10" BLOCK;
    CheckRule "$RFI >= 10" BLOCK;
    CheckRule "$TRAVERSAL >= 5" BLOCK;
    CheckRule "$EVADE >= 5" BLOCK;
    CheckRule "$XSS >= 10" BLOCK;
    DeniedUrl "/naxsi.html"; 
    include   /etc/nginx/naxsi/naxsi-wordpress.rules;
}
```

For the `DeniedUrl` rule to work, create a file named `naxsi.html` in the root directory.

## License
This software is distributed under the MIT license. Please read `LICENSE` for information on the software availability and distribution.
