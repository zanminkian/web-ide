#!/usr/bin/env zsh
set -e

CODE_SERVER_VERSION=4.17.1
curl -L https://github.com/coder/code-server/releases/download/v$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz -o /usr/lib/code-server.tgz
tar -xf /usr/lib/code-server.tgz -C /usr/lib
mv /usr/lib/code-server-$CODE_SERVER_VERSION-linux-amd64 /usr/lib/code-server
rm -rf /usr/lib/code-server.tgz

export EXTENSIONS_GALLERY='{"serviceUrl":"https://marketplace.visualstudio.com/_apis/public/gallery"}'
# common
/usr/lib/code-server/bin/code-server --install-extension mhutchie.git-graph@1.30.0 # not perfect. remove it one day
/usr/lib/code-server/bin/code-server --install-extension ryu1kn.partial-diff
/usr/lib/code-server/bin/code-server --install-extension christian-kohler.path-intellisense
/usr/lib/code-server/bin/code-server --install-extension streetsidesoftware.code-spell-checker
/usr/lib/code-server/bin/code-server --install-extension wmaurer.change-case
/usr/lib/code-server/bin/code-server --install-extension shardulm94.trailing-spaces
/usr/lib/code-server/bin/code-server --install-extension oderwat.indent-rainbow
/usr/lib/code-server/bin/code-server --install-extension wwm.better-align
/usr/lib/code-server/bin/code-server --install-extension njzy.stats-bar
/usr/lib/code-server/bin/code-server --install-extension humao.rest-client # not perfect
# go
/usr/lib/code-server/bin/code-server --install-extension golang.Go@0.38.0
# js
/usr/lib/code-server/bin/code-server --install-extension bradlc.vscode-tailwindcss
/usr/lib/code-server/bin/code-server --install-extension formulahendry.auto-rename-tag
# sytax
/usr/lib/code-server/bin/code-server --install-extension IronGeek.vscode-env
/usr/lib/code-server/bin/code-server --install-extension GraphQL.vscode-graphql-syntax
/usr/lib/code-server/bin/code-server --install-extension pbkit.vscode-pbkit
/usr/lib/code-server/bin/code-server --install-extension mrkou47.thrift-syntax-support
# removed
# code-server --install-extension usernamehw.errorlens # too noisy
# code-server --install-extension ppz.ppz # some error logs appear
# code-server --install-extension steoates.autoimport # it seems that it have some bugs

# vscode setting
echo '{
  // extension
  "extensions.autoCheckUpdates": false,
  "extensions.autoUpdate": false,
  // workbench
  "workbench.startupEditor": "none",
  "workbench.colorTheme": "Default Dark Modern",
  "workbench.tree.renderIndentGuides": "always",
  // editor
  // "editor.linkedEditing": true, // There are some bugs in tsx file when enabling this. Use `Auto Rename Tag` extension intead.
  "editor.guides.bracketPairs": true,
  "editor.showFoldingControls": "always",
  "editor.renderWhitespace": "all",
  "editor.tabSize": 2,
  "editor.quickSuggestions": {
    "strings": "on"
  },
  // file readonly
  "files.readonlyFromPermissions": true,
  "files.readonlyInclude": {
    "**/{package-lock.json,pnpm-lock.yaml,yarn.lock}": true,
    "**/node_modules/**/*": true,
    "**/.pnpm-store/**/*": true,
    "**/go.sum": true,
  },
  // others
  "window.commandCenter": false,
  "debug.toolBarLocation": "docked",
  "security.workspace.trust.enabled": false,
  "update.mode": "none",
}' > ~/.local/share/code-server/User/settings.json

# code-server config
sed -i '/^bind-addr:/d' ~/.config/code-server/config.yaml
echo 'bind-addr: 0.0.0.0:8080' >> ~/.config/code-server/config.yaml
sed -i '/^disable-update-check:/d' ~/.config/code-server/config.yaml
echo 'disable-update-check: true' >> ~/.config/code-server/config.yaml

# env
echo "# code-server
export PATH=\$PATH:/usr/lib/code-server/bin
export EXTENSIONS_GALLERY='{\"serviceUrl\":\"https://marketplace.visualstudio.com/_apis/public/gallery\"}' # https://coder.com/docs/code-server/latest/FAQ#how-do-i-use-my-own-extensions-marketplace
export CODESPACES='true' # Disable golang extension's welcome page. Check https://github.com/golang/vscode-go/issues/1246
alias code='code-server'
" >> ~/.zshrc
