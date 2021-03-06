#!/bin/bash
set -eux

## For Elastic Search
echo "vm.max_map_count=262144" >> /etc/sysctl.conf&&sysctl -p&&cat /proc/sys/vm/max_map_count

## For Docker Daemon

mkdir -p /etc/docker && touch /etc/docker/daemon.json
cat << EOF > /etc/docker/daemon.json
{
  "storage-driver": "overlay2",
  "log-driver": "json-file",
  "data-root": "/docker",
  "log-opts": {
    "max-size" : "200m"
  }
}
EOF

systemctl daemon-reload
systemctl restart docker


