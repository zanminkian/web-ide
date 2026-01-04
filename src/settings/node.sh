#!/usr/bin/env zsh
set -e

eval "$(jrm env)"

jrm install node@22
jrm install node@20

jrm use node@22
# @arethetypeswrong/cli loadtest cloc pm2 npm-check-updates tree-cli del-cli
npm i -g http-server
npm i -g npm-check-updates
npm i -g degit
npm i -g fenge
npm i -g @rnm/gpp

jrm use node@20
npm i -g @rnm/pm
pm-cli enable-shim

jrm use node@22
npm i -g @rnm/pm
pm-cli enable-shim

# TODO: Remove this if this [issue](https://github.com/pnpm/pnpm/issues/5803) is solved.
# Refer: https://github.com/pnpm/pnpm/issues/7024#issuecomment-1740740451.
# Another solution: https://github.com/pnpm/pnpm/issues/5803#issuecomment-2710571371.
mkdir -p ~/.config/pnpm
echo 'package-import-method=clone-or-copy' >> ~/.config/pnpm/rc

echo '# node
eval "$(jrm env)"
' >> ~/.zshrc

if which code >/dev/null 2>&1; then
  code --install-extension bradlc.vscode-tailwindcss
  # code --install-extension formulahendry.auto-rename-tag # Prefer enabling vscode built-in conifg `editor.linkedEditing`
fi
