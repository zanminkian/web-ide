#!/usr/bin/env zsh
set -e

ARCH=$(arch)
echo "node: current arch is $ARCH"
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
eval "`fnm env --shell zsh`"

fnm install 16
fnm install 18
fnm install 20
fnm install 22
fnm use 18
corepack enable
corepack prepare --all
npm i -g ts-node tsx npm-check-updates del-cli http-server pm2 degit # @arethetypeswrong/cli loadtest cloc

echo '# node
eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive)" # for fnm
alias cnpx="npx --registry=https://registry.npmmirror.com"
alias cnpm="npm --registry=https://registry.npmmirror.com"
alias cpnpm="pnpm --registry=https://registry.npmmirror.com"
' >> ~/.zshrc

if which code >/dev/null 2>&1; then
  code --install-extension bradlc.vscode-tailwindcss
  code --install-extension formulahendry.auto-rename-tag
fi

echo "install node success"
