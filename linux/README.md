# Linux Config

Some configs of sysctl, sshd, ulimit...

## sysctl

See `./99-tuning_sysctl.conf`.

## sshd

See `./99-hardening_sshd`.

## ulimit

```bash
sudo vi /etc/security/limits.conf
```

Add:

```conf
* soft nofile 1048576
* hard nofile 1048576

* soft nproc 65535
* hard nproc 65535

* soft memlock unlimited
* hard memlock unlimited
```
