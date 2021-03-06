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

if gradle -v  ; then
  exit 0
fi

if ! isInstalled unzip.x86_64; then yum install -y unzip.x86_64; fi

wget -q https://services.gradle.org/distributions/gradle-6.8.3-bin.zip -P /tmp
unzip -o -d /opt/gradle /tmp/gradle-6.8.3-bin.zip

cat << EOF > /etc/profile.d/gradle.sh
export GRADLE_HOME=/opt/gradle/gradle-6.8.3
export PATH=/opt/gradle/gradle-6.8.3/bin:${PATH}
EOF

