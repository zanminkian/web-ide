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

fnm install 22
fnm install 20
fnm install 18

# @arethetypeswrong/cli loadtest cloc pm2 npm-check-updates tree-cli
npm i -g tsx
npm i -g del-cli
npm i -g @antfu/ni
npm i -g http-server
npm i -g degit

# TODO: Remove the enabling when corepack is stable
corepack enable

echo '# node
eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive)" # for fnm
export COREPACK_NPM_REGISTRY=$(npm config get registry) # TODO: remove this line when https://github.com/nodejs/corepack/issues/540 is closed
' >> ~/.zshrc

if which code >/dev/null 2>&1; then
  code --install-extension bradlc.vscode-tailwindcss
  # code --install-extension formulahendry.auto-rename-tag # Prefer enabling vscode built-in conifg `editor.linkedEditing`
fi
