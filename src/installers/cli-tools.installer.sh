#!/usr/bin/env zsh
set -e

# install ttyd
# curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd
# chmod +x /usr/local/bin/ttyd

## install tools via apt
echo "cli-tools: install begin. $(arch)"
apt update
apt install -y mysql-client redis-tools tree
echo "cli-tools: install success. $(arch)"
# apt install -y nginx