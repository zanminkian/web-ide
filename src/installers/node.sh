#!/usr/bin/env zsh
set -e

ARCH=$(arch)
if [ $ARCH = "x86_64" ]; then
  ARCH="linux"
else
  ARCH="arm64"
fi

# install fnm
curl -L https://github.com/Schniz/fnm/releases/latest/download/fnm-$ARCH.zip -o /usr/local/bin/fnm-$ARCH.zip
unzip /usr/local/bin/fnm-$ARCH.zip -d /usr/local/bin
rm -rf /usr/local/bin/fnm-$ARCH.zip
chmod +x /usr/local/bin/fnm
