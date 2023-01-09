#!/usr/bin/env zsh
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o /usr/local/bin/n
chmod +x /usr/local/bin/n
n 16
npm i -g pnpm yarn ts-node tsx loadtest http-server pm2 cloc npm-check-updates
