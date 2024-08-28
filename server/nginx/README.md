# Nginx

I encrypted the configuration files for security.

## Compile

CentOS/Fedora/Euler
```bash
sudo yum install -y pcre-devel zlib-devel libxslt-devel geoip-devel libuuid-devel
```

Debian/Ubuntu/Kali
```bash
sudo apt install libxslt1-dev zlib1g-dev libpcre2-dev libgeoip-dev uuid-dev
```

Source: [nginx(>= v1.25.0, builtin HTTP/3 support)](https://hg.nginx.org/nginx)

Compile command(with LibreSSL by [Homebrew](https://brew.sh/)):
```bash
export BREW_LIBRESSL_VERSION=3.9.2

./configure --prefix=/opt/data/etc/nginx \
  --user=nobody --group=nobody \
  --with-http_v3_module \
  --with-http_ssl_module \
  --with-http_v2_module \
  --with-http_realip_module \
  --with-http_addition_module \
  --with-http_sub_module \
  --with-http_random_index_module \
  --with-http_secure_link_module \
  --with-http_stub_status_module \
  --with-http_auth_request_module \
  --with-http_slice_module \
  --with-http_geoip_module \
  --with-threads --with-file-aio \
  --with-pcre --with-mail --with-stream \
  --with-mail_ssl_module --with-stream_ssl_module \
  --with-http_gunzip_module --with-http_gzip_static_module \
  --add-module=../ngx_brotli --with-compat \
  --add-module=../incubator-pagespeed-ngx \
  --with-cc-opt="-I/home/linuxbrew/.linuxbrew/Cellar/libressl/${BREW_LIBRESSL_VERSION}/include" \
  --with-ld-opt="-L/home/linuxbrew/.linuxbrew/Cellar/libressl/${BREW_LIBRESSL_VERSION}/lib"
make -j2
make install
```

### Pagespeed

```txt
https://nova.moe/serve-webp-on-the-fly-with-nginx-and-mod_pagespeed/
https://www.modpagespeed.com/doc/build_ngx_pagespeed_from_source
https://github.com/apache/incubator-pagespeed-ngx/issues/1743
https://github.com/apache/incubator-pagespeed-ngx/issues/1533
```

### Webdav

Using `dufs` instead of `nginx-dav-ext-module`.

### [LibreSSL](https://www.libressl.org)

```bash
brew install libressl
```

Move library of OpenSSL to `/usr/lib`(Ubuntu):
```bash
sudo cp /home/linuxbrew/.linuxbrew/Cellar/libressl/*/lib/libcrypto.so.52 /usr/lib64 
sudo cp /home/linuxbrew/.linuxbrew/Cellar/libressl/*/lib/libssl.so.55 /usr/lib64 
```

## Configuration

### Certificate with Let's Encrypt


```bash
export LE_DIR="/opt/data/letsencrypt"

certbot certonly \
  -d example.com -d *.example.com \
  --manual \
  --preferred-challenges dns-01 \
  --email no-reply@example.com \
  --server https://acme-v02.api.letsencrypt.org/directory \
  --manual-auth-hook ${LE_DIR}/certbot-auth-dnspod.sh \
  --manual-cleanup-hook "${LE_DIR}/certbot-auth-dnspod.sh clean" \
  --config-dir ${LE_DIR} \
  --work-dir ${LE_DIR} \
  --logs-dir ${LE_DIR}
```

### Self-sign Certificate

```
cert.zip
 |_ private.key
 |_ cacert.pem
```

## Test

### HTTP/3

[HTTP/3 Check](https://www.http3check.net/)

### OCSP

```bash
openssl s_client -connect example:443 -status -tlsextdebug < /dev/null 2>&1 | grep "OCSP response"
```

