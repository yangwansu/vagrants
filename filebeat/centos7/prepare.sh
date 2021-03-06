#!/bin/bash

set -eux
info()
{
    echo '[INFO] ' "$@"
}
warn()
{
    echo '[WARN] ' "$@" >&2
}
fatal()
{
    echo '[ERROR] ' "$@" >&2
    exit 1
}

isInstalled() {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

if [ ! -f /etc/redhat-release ]; then
  fatal 'Do not Support ';
fi

yum -y -q update

if ! isInstalled yum-utils; then yum install -y yum-utils; fi
# if ! isInstalled redhat-lsb; then yum -y install redhat-lsb; fi
# if ! isInstalled nc; then yum -y install nc; fi
# if ! isInstalled ntp.x86_64; then yum -y install ntp.x86_64; fi #ntpd
# if ! isInstalled net-tools; then yum -y install net-tools; fi #natstat
# if ! isInstalled python-yaml; then yum -y install python-yaml; fi
# yum -y erase iptables.x86_64

localedef --quiet  -c -i ko_KR -f UTF-8 ko_KR.UTF-8
timedatectl set-timezone Asia/Seoul
