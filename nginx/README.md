#!/usr/bin/env bash

# nginx-quic

./auto/configure --prefix=/usr/local/nginx-quic \
  --user=nginx --group=nginx \
  --with-http_v3_module \
  --with-stream_quic_module \
  --with-http_ssl_module \
  --with-http_v2_module \
  --with-http_realip_module \
  --with-http_addition_module \
  --with-http_sub_module \
  --with-http_dav_module \
  --with-http_gunzip_module \
  --with-http_gzip_static_module \
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
  --with-cc-opt=-I../boringssl/include \
  --with-ld-opt='-L../boringssl/build/ssl -L../boringssl/build/crypto'
