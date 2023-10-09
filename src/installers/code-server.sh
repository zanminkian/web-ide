#!/usr/bin/env zsh
set -e

CODE_SERVER_VERSION=4.17.1
curl -L https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb -o /tmp/code-server.deb
dpkg -i /tmp/code-server.deb
rm -rf /tmp/code-server.deb

export EXTENSIONS_GALLERY='{"serviceUrl":"https://marketplace.visualstudio.com/_apis/public/gallery"}'
# common
code-server --install-extension mhutchie.git-graph@1.30.0 # not perfect. remove it one day
code-server --install-extension ryu1kn.partial-diff
code-server --install-extension christian-kohler.path-intellisense
code-server --install-extension streetsidesoftware.code-spell-checker
code-server --install-extension wmaurer.change-case
code-server --install-extension shardulm94.trailing-spaces
code-server --install-extension oderwat.indent-rainbow
code-server --install-extension wwm.better-align
code-server --install-extension njzy.stats-bar
code-server --install-extension humao.rest-client # not perfect
# go
code-server --install-extension golang.Go@0.38.0
# js
code-server --install-extension bradlc.vscode-tailwindcss
code-server --install-extension formulahendry.auto-rename-tag
# sytax
code-server --install-extension IronGeek.vscode-env
code-server --install-extension GraphQL.vscode-graphql-syntax
code-server --install-extension pbkit.vscode-pbkit
code-server --install-extension mrkou47.thrift-syntax-support
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
export EXTENSIONS_GALLERY='{\"serviceUrl\":\"https://marketplace.visualstudio.com/_apis/public/gallery\"}' # https://coder.com/docs/code-server/latest/FAQ#how-do-i-use-my-own-extensions-marketplace
export CODESPACES='true' # Disable golang extension's welcome page. Check https://github.com/golang/vscode-go/issues/1246
alias code='code-server'
" >> ~/.zshrc
