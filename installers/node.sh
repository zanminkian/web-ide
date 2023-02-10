#!/usr/bin/env zsh

set -e

curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o /usr/local/bin/n
chmod +x /usr/local/bin/n
n 16
npm i -g pnpm ts-node tsx loadtest http-server pm2 cloc npm-check-updates

echo '\n# node' >> ~/.zshrc
echo 'alias cnpm="npm --registry=https://registry.npmmirror.com"' >> ~/.zshrc
