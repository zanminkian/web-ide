#!/usr/bin/env zsh
set -e

curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o /usr/local/bin/n
chmod +x /usr/local/bin/n
n 16
corepack enable
corepack prepare --all
npm i -g ts-node tsx npm-check-updates del-cli http-server pm2 degit @arethetypeswrong/cli loadtest cloc

echo '# node
alias cnpx="npx --registry=https://registry.npmmirror.com"
alias cnpm="npm --registry=https://registry.npmmirror.com"
alias cpnpm="pnpm --registry=https://registry.npmmirror.com"
' >> ~/.zshrc
