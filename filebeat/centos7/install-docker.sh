#!/bin/bash
set -eux

if ! docker -v;
then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  usermod -aG docker vagrant
  systemctl enable docker.service
  systemctl start docker
fi




