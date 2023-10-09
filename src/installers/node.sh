#!/usr/bin/env zsh
set -e

# install fnm
curl -L https://github.com/Schniz/fnm/releases/latest/download/fnm-linux.zip -o /usr/local/bin/fnm-linux.zip
unzip /usr/local/bin/fnm-linux.zip -d /usr/local/bin
rm -rf /usr/local/bin/fnm-linux.zip
chmod +x /usr/local/bin/fnm
eval "`fnm env`"

fnm use 16 --install-if-missing
corepack enable
corepack prepare --all
npm i -g ts-node tsx npm-check-updates del-cli http-server pm2 degit # @arethetypeswrong/cli loadtest cloc

echo '# node
eval "`fnm env`" # for fnm
alias cnpx="npx --registry=https://registry.npmmirror.com"
alias cnpm="npm --registry=https://registry.npmmirror.com"
alias cpnpm="pnpm --registry=https://registry.npmmirror.com"
' >> ~/.zshrc
