# Server

Application/Service running on Linux server.

## crontab

```crontab
# Main User
0 2 1 * *   /usr/bin/env bash /opt/data/etc/certbot_renew.sh >> /opt/data/log/certbot_renew.log 2>&1
0 0 15 * *  /usr/bin/env bash /opt/data/etc/vault_auto_backup.sh /opt/data/server/vault > /dev/null 2>&1
*/5 * * * * /opt/data/workspace/ddns-by-dnspod/.venv/bin/python /opt/data/workspace/ddns-by-dnspod/ddns.py /opt/data/workspace/ddns-by-dnspod/config.yaml >> /opt/data/log/ddns.log 2>&1
0 8 * * *   /opt/data/pyvenv/work/bin/python /opt/data/workspace/config/python/chery_auto_checkout.py /opt/data/etc/chery_auto_checkout.yaml >> /opt/data/log/auto_checkout.log 2>&1
#0 3 */5 * * cd /data/byte-unixbench/UnixBench && ./Run >> /data/logs/unixbench/stress_test.log 2>&1

# Root
0 */12 * * * /usr/bin/env bash /root/update-hosts/update_hosts.sh > /dev/null 2>&1
```

## hosts

```hosts
# Main interface
192.168.1.1 local

# GITHUB HOSTS BEGIN
# GITHUB HOSTS END
```

## logrotate

Logrotate can rotate log daily/weekly/monthly, can also detect log size and rotate it.

- log directory mode: 700
- config file mode:   644

### nginx

```logrotate
/opt/data/log/nginx/json_access.log
/opt/data/log/nginx/error.log
{
  su zhang zhang
  daily
  rotate 185
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

## Docker / Podman

Runing a container:

```bash
podman run -itd --name <container_name> \
  --restart always \
  -p <host_port>:<container_port> \
  -e <CONTAINER_ENV_NAME>=<value> \
  -v <host_path>:<container_path> \
  <image_name>:<version> [enter_point]
```

State of container:

```txt
                    running
     `pause/unpause`       `kill/start`
 paused                               stoped
```

### logs

Execute `sed -i 's%driver: json-file%driver: k8s-file%'` to use k8s-file driver because
the [Podman not support JSON log](https://github.com/containers/podman/issues/16317).

Execute `podman inspect --format='{{.HostConfig.LogConfig}}' <container_name>`
to show the location of the log file.

### networks

Create a newtork.

```bash
podman network create local_containers --driver bridge --gateway 10.25.0.1 --subnet 10.25.0.0/20
```

Allocate IP address for containers or services:

|Service|Port|IP|Comment|
|-|-|-|-|
|proxy|1080|-|by Go|
|dufs|1110|10.25.11.10|-|
|vault|1120|10.25.11.20|-|
|code|1130|10.25.11.30|-|
|drop|1140|10.25.11.40|-|
|anki-sync|1150|10.25.11.50|-|
|memos|1160|10.25.11.60|-|
|matrix|1170|10.25.11.70|-|
|ntfy|1180|10.25.11.80|-|
|postgresql|1210|10.25.12.10|-|

### mirrors

```toml
unqualified-search-registries = ["docker.io", "ghcr.io"]

[[registry]]
prefix = "docker.io"
location = "docker.1ms.run"
#location = "docker.xuanyuan.me"
#location = "docker-0.unsee.tech"
#location = "docker.m.daocloud.io"
insecure = true

[[registry]]
prefix = "ghcr.io"
location = "ghcr.nju.edu.cn"
insecure = true
```

## Unused Services

- QingLong
- RustDesk
- MySQL
- MongoDB
- Redis
- Grafana
- Minio
- Immich
- Technitium(DNS)
- Gotify
- SimpleX(SMP/XFTP)
