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
