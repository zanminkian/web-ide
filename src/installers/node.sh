#!/usr/bin/env zsh

set -e

curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o /usr/local/bin/n
chmod +x /usr/local/bin/n
n 16
corepack enable
corepack prepare --all
npm i -g ts-node tsx loadtest http-server pm2 cloc npm-check-updates


echo '# node
alias cnpm="npm --registry=https://registry.npmmirror.com"
' >> ~/.zshrc
