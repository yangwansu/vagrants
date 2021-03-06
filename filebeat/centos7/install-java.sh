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

if ! isInstalled java-1.8.0-openjdk; then yum install -y -q java-1.8.0-openjdk; fi
