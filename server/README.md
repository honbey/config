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

```txt
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

```
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

```
                    running
     `pause/unpause`       `kill/start`
 paused                               stoped
```

### networks

Create a newtork.

```bash
podman network create local_containers --driver bridge --gateway 10.25.0.1 --subnet 10.25.0.0/20
```

Allocate IP address for containers or services:

| Service | Port| IP| Comment |
| --------------- | --------------- | --------------- |--------------- |
|ollama|1030|10.25.10.30| unprivilege port |
|redis|1040|10.25.10.40| |
|mongo/sql|1050|10.25.10.50| |
|anki|1060| | by Python |
|ledger|1070| | by Python |
|proxy|1080| | by Go |
|dufs|1110|10.25.11.10| |
|vault|1120|10.25.11.20| |
|code|1130|10.25.11.30| |
|drop|1140|10.25.11.40| |
|gotify|1150|10.25.11.50| |
|memos|1160|10.25.11.60| |
