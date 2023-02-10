#!/usr/bin/env zsh

set -ex

curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.2/ttyd.x86_64 -o /usr/local/bin/ttyd
chmod +x /usr/local/bin/ttyd
