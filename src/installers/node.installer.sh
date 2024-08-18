#!/usr/bin/env zsh
set -e

ARCH=$(arch)
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
eval "$(fnm env --shell=zsh)"

fnm install 18
fnm install 20
fnm install 22
corepack enable
corepack install -g pnpm
corepack install -g yarn

# @arethetypeswrong/cli loadtest cloc pm2 npm-check-updates
echo "installing ts-node"
npm i -g ts-node
echo "installing tsx"
npm i -g tsx
echo "installing del-cli"
npm i -g del-cli
echo "installing http-server"
npm i -g http-server
echo "installing degit"
npm i -g degit

echo '# node
eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive)" # for fnm
export COREPACK_NPM_REGISTRY=$(npm config get registry) # TODO: remove this line when https://github.com/nodejs/corepack/issues/540 is closed
alias cnpx="npx --registry=https://registry.npmmirror.com"
alias cnpm="npm --registry=https://registry.npmmirror.com"
alias cpnpm="pnpm --registry=https://registry.npmmirror.com"
' >> ~/.zshrc

if which code >/dev/null 2>&1; then
  code --install-extension bradlc.vscode-tailwindcss
  code --install-extension formulahendry.auto-rename-tag
fi
