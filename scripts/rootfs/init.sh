#!/bin/sh
set -e

source ./config/config.conf  

mkdir -p rootfs/{bin,sbin,dev,proc,sys,tmp,var/log,etc,lib64,pkg}
mkdir -p rootfs/usr/{bin,sbin}
mkdir -p rootfs/{home,run,mnt,media}

cat <<EOF > rootfs/etc/hosts
127.0.0.1 localhost
::1       localhost
EOF

echo "hosts: files dns" > rootfs/etc/nsswitch.conf

cat <<EOF > rootfs/etc/os-release
NAME="$OS_NAME"
VERSION="$VERSION"
ID=$AUTHOR
PRETTY_NAME="$OS_NAME 0.1"
EOF

# ANSI color codes
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
MAGENTA="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
RESET="\[\033[0m\]"


cat <<EOF > rootfs/etc/profile
export PS1="$CYAN@$GREEN\u$WHITE:$BLUE\w$RESET# "
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:\$PATH"
EOF




cat <<EOF > rootfs/etc/resolv.conf
nameserver 8.8.8.8
nameserver 1.1.1.1
EOF

cat > rootfs/etc/passwd <<EOF
root:x:0:0:root:/root:/bin/sh
user:x:1000:1000:User:/home/user:/bin/sh
EOF

cat > rootfs/etc/shadow <<EOF
root::0:0:99999:7:::
user::0:0:99999:7:::
EOF
chmod 600 rootfs/etc/shadow

cat > rootfs/etc/group <<EOF
root:x:0:
user:x:1000:
EOF


mkdir -p rootfs/etc/ssl/certs

cp -r /etc/ssl/certs/* rootfs/etc/ssl/certs/ 2>/dev/null || true

[ ! -f rootfs/etc/ssl/certs/ca-certificates.crt ] && \
  wget https://curl.se/ca/cacert.pem -O rootfs/etc/ssl/certs/ca-certificates.crt
