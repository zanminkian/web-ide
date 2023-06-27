#!/usr/bin/env zsh
set -e

curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o /usr/local/bin/n
chmod +x /usr/local/bin/n
n 16
corepack enable
corepack prepare --all
npm i -g ts-node tsx http-server pm2 npm-check-updates degit loadtest cloc

echo '# node
alias cnpm="npm --registry=https://registry.npmmirror.com"
' >> ~/.zshrc
