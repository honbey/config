# TODO: NEED UPDATE
# Server

Application/Service running on Linux server.

## crontab

```
# Main User
* 1-6 * * * /usr/bin/env bash /data/ddns-dnspod/dnspod_ddns.sh >> /data/logs/ddns/log 2>&1
0 2 1 * *   /usr/bin/env bash /data/certbot-auth-dnspod/certbot_renew.sh >> /data/logs/letsencrypt/certbot_renew.log 2>&1
0 0 15 * *  /usr/bin/env bash /data/server/vaultwarden/auto_bak_config.sh /data/server/vaultwarden > /dev/null 2>&1
0 3 */5 * * cd /data/byte-unixbench/UnixBench && ./Run >> /data/logs/unixbench/stress_test.log 2>&1

# Root
0 */12 * * * /usr/bin/env bash /root/update-hosts/update_hosts.sh > /dev/null 2>&1
```

## hosts

```
# Main interface
192.168.1.100 local

# podman-br-con NET 10.1.0.0/16
10.1.1.10 mysql

10.1.2.10 vaultwarden

10.1.3.10 promtail

10.1.5.10 ghost

# docker-br-con NET 10.2.0.0/16
10.2.0.10 mailserver

10.2.3.10 promtail
10.2.3.20 loki
10.2.3.30 grafana

10.2.4.10 minio

# GITHUB BEGIN
# GITHUB END
```

## logrotate

Logrotate can rotate log daily/weekly/monthly, can also detect log size and rotate it.

- log directory mode: 700
- config file mode:   644

### nginx

```
/opt/data/log/nginx/json_access.log
/opt/data/log/nginx/error.log
{
  daily
  rotate 365
  missingok
  notifempty
  dateext
  compress
  olddir /opt/data/log/nginx/backups
  postrotate
    if [ -f /opt/data/log/nginx/pid ]; then
      kill -USR1 $(cat /opt/data/log/nginx/pid)
    fi
  endscript
}
```

### monitor host

```
/opt/data/log/host/json_host.log
{
  daily
  rotate 7
  missingok
  notifempty
  dateext
  compress
  olddir /opt/data/log/host/backups
  copytruncate
}
```

## Docker

Runing a container:

```bash
docker run -itd --name <container_name> \
  --restart always \
  --privileged \
  -p <host_port>:<container_port> \
  -e <CONTAINER_ENV_NAME>=<value> \
  -v <host_path>:<container_path> \
  <image_name>:<version> [enter_point]
```

State of container:
```
                    running
     `pause/unpause`       `kill/start`
 paused                               stoped
```

## Podman

Some containers with `podman-compose` need add parameters for `podman-run`:

### MySQL

```bash
podman-compose --podman-run-args '--ip 10.1.1.10' up -d
```

### MongoDB

```bash
podman-compose --podman-run-args '--ip 10.1.1.20 --privileged' up -d
```

### Vaultwarden

```bash
podman-compose --podman-run-args '--ip 10.1.2.10' up -d
```

### Promtail

```bash
podman-compose --podman-run-args '--ip 10.1.3.10' up -d
```

### Ghost

```bash
podman-compose --podman-run-args '--ip 10.1.5.10' up -d
```

