#!/usr/bin/env zsh
set -e

# install ttyd
curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd
chmod +x /usr/local/bin/ttyd

## install nginx and mysql client
apt update
apt install -y nginx mysql-client