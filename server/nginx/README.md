# Nginx with QUIC

I encrypted the configuration files for security.

## Compile

CentOS/Fedora/Euler
```bash
sudo yum install -y pcre-devel zlib-devel libxslt-devel geoip-devel
```

Debian/Ubuntu/Kali
```bash
sudo apt install libxslt1-dev zlib1g-dev libpcre2-dev libgeoip-dev
```

Source: [nginx(>= v1.25.0)](https://hg.nginx.org/nginx)

Compile command(with OpenSSL 3.0):
```bash
./configure --prefix=/var/data/etc/nginx \
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
  --with-threads \
  --with-file-aio \
  --with-pcre \
  --with-mail \
  --with-stream \
  --with-mail_ssl_module \
  --with-stream_ssl_module \
  --with-http_dav_module --add-module=../nginx-dav-ext-module \
  --with-http_gunzip_module \
  --with-http_gzip_static_module --add-module=../ngx_brotli \
  --with-compat --add-module=../incubator-pagespeed-ngx
  --with-cc-opt=-I../openssl/include \
  --with-ld-opt='-L../openssl -L../openssl'
make -j2
make install
```

Compile command(with BoringSSL):
```bash
./auto/configure --prefix=/var/data/etc/nginx \
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
  --with-threads \
  --with-file-aio \
  --with-pcre \
  --with-mail \
  --with-stream \
  --with-mail_ssl_module \
  --with-stream_ssl_module \
  --with-http_dav_module --add-module=../nginx-dav-ext-module \
  --with-http_gunzip_module \
  --with-http_gzip_static_module --add-module=../ngx_brotli \
  --with-compat --add-module=../incubator-pagespeed-ngx
  --with-cc-opt=-I../boringssl/include \
  --with-ld-opt='-L../boringssl/build/ssl -L../boringssl/build/crypto'
make -j2
make install
```

### OpenSSL 3.0 with QUIC

Clone from GitHub:
```bash
git clone --depth=1 -b openssl-3.0.8+quic https://github.com/quictls/openssl
```

Make:

> It's unnecessary to execute `make install`!

```bash
cd openssl
./config
make -j4
cd ..
```

Move library of OpenSSL to `/usr/lib64`:
```bash
sudo cp openssl/libssl.so.81.3 /usr/lib64 
sudo cp openssl/libcrypto.so.81.3 /usr/lib64 
```

### BoringSSL

## Configuration

### Certificate with Let's Encrypt


```bash
certbot certonly \
  -d example.com -d *.example.com \
  --manual \
  --preferred-challenges dns-01 \
  --email no-reply@example.com \
  --server https://acme-v02.api.letsencrypt.org/directory \
  --manual-auth-hook /var/data/letsencrypt/certbot-auth-dnspod.sh \
  --manual-cleanup-hook "/var/data/letsencrypt/certbot-auth-dnspod.sh clean" \
  --config-dir /var/data/letsencrypt \
  --work-dir /var/data/letsencrypt \
  --logs-dir /var/data/letsencrypt
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

### Pagespeed

```txt
https://nova.moe/serve-webp-on-the-fly-with-nginx-and-mod_pagespeed/
https://www.modpagespeed.com/doc/build_ngx_pagespeed_from_source
https://github.com/apache/incubator-pagespeed-ngx/issues/1743
```
