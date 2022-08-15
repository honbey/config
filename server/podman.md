
yum install -y \
  btrfs-progs-devel \
  conmon \
  containernetworking-plugins \
  device-mapper-devel \
  git \
  glib2-devel \
  glibc-devel \
  glibc-static \
  go \
  gpgme-devel \
  iptables \
  libassuan-devel \
  libgpg-error-devel \
  libseccomp-devel \
  libselinux-devel \
  make \
  pkgconfig

# https://podman.io/getting-started/installation

git clone --depth=1 https://github.com/containers/conmon
cd conmon
export GOCACHE="$(mktemp -d)"
make
make podman
cd ..

git clone --depth=1 https://github.com/opencontainers/runc.git
cd runc
make BUILDTAGS="selinux seccomp"
cp runc /usr/bin/runc
cd ..

http://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages/libslirp-4.4.0-4.el9.x86_64.rpm
http://mirror.stream.centos.org/9-stream/CRB/x86_64/os/Packages/libslirp-devel-4.4.0-4.el9.x86_64.rpm
http://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages/slirp4netns-1.2.0-2.el9.x86_64.rpm

rpm -i libslirp-4.4.0-4.el9.x86_64.rpm
rpm -i libslirp-devel-4.4.0-4.el9.x86_64.rpm

yum install autoconf automake glib2-devel libcap-devel libseccomp-devel

git clone --depth=1 https://github.com/rootless-containers/slirp4netns
cd slirp4netns
./autogen.sh
./configure --prefix=/usr # LDFLAGS=-static
make
make install
cd ..

git clone --depth=1 -b v4.2.0 https://github.com/containers/podman
cd podman
make BUILDTAGS="selinux seccomp"
make install PREFIX=/usr
cd ..

vi /usr/lib64/pkgconfig/gpgme.pc

prefix=/usr
exec_prefix=/usr
includedir=/usr/include
libdir=/usr/lib64
host=x86_64-redhat-linux-gnu
api_version=1

Name: gpgme
Description: GnuPG Made Easy to access GnuPG
Requires: gpg-error, libassuan
Version: 1.16.0
Cflags:
Libs: -lgpgme
URL: https://www.gnupg.org/software/gpgme/index.html

vi /usr/lib64/pkgconfig/gpgme-glib.pc

prefix=/usr
exec_prefix=/usr
includedir=/usr/include
libdir=/usr/lib64
host=x86_64-redhat-linux-gnu
api_version=1

Name: gpgme-glib
Description: GnuPG Made Easy to access GnuPG with Glib
Requires: gpg-error, libassuan, glib-2.0
Version: 1.16.0
Cflags:
Libs: -lgpgme
URL: https://www.gnupg.org/software/gpgme/index.html

mkdir cat /etc/containers

vi /etc/containers/registries.conf

# An array of host[:port] registries to try when pulling an unqualified image, in order.
unqualified-search-registries = ["docker.io"]
vi /etc/containers/policy.conf

{
    "default": [
        {
            "type": "insecureAcceptAnything"
        }
    ],
    "transports":
        {
            "docker-daemon":
                {
                    "": [{"type":"insecureAcceptAnything"}]
                }
        }
}

/usr/sbin/iptables -t nat -S --wait

https://raw.githubusercontent.com/containers/podman-compose/devel/podman_compose.py


