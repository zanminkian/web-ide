#!/usr/bin/env zsh
set -e

eval "$(fnm env --shell=zsh)"

fnm install 22
fnm install 20

# @arethetypeswrong/cli loadtest cloc pm2 npm-check-updates tree-cli del-cli
npm i -g tsx # TODO: Remove this when Node 24 is stable.
npm i -g http-server
npm i -g npm-check-updates
npm i -g degit
npm i -g fenge

fnm use 20
npm i -g @rnm/pm
pm-cli enable-shim

fnm use 22
npm i -g @rnm/pm
pm-cli enable-shim

# TODO: Remove this if this [issue](https://github.com/pnpm/pnpm/issues/5803) is solved.
# Refer: https://github.com/pnpm/pnpm/issues/7024#issuecomment-1740740451.
# Another solution: https://github.com/pnpm/pnpm/issues/5803#issuecomment-2710571371.
mkdir -p ~/.config/pnpm
echo 'package-import-method=clone-or-copy' >> ~/.config/pnpm/rc

echo '# node
eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive)" # for fnm
' >> ~/.zshrc

if which code >/dev/null 2>&1; then
  code --install-extension bradlc.vscode-tailwindcss
  # code --install-extension formulahendry.auto-rename-tag # Prefer enabling vscode built-in conifg `editor.linkedEditing`
fi
