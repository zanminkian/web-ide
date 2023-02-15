#!/usr/bin/env zsh

set -e

CODE_SERVER_VERSION=4.9.1
wget https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb
dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb
rm -rf code-server_${CODE_SERVER_VERSION}_amd64.deb

export EXTENSIONS_GALLERY='{"serviceUrl":"https://marketplace.visualstudio.com/_apis/public/gallery"}'
code-server --install-extension GraphQL.vscode-graphql-syntax
code-server --install-extension IronGeek.vscode-env
code-server --install-extension christian-kohler.path-intellisense
code-server --install-extension esbenp.prettier-vscode
code-server --install-extension golang.Go
code-server --install-extension humao.rest-client
code-server --install-extension mhutchie.git-graph
code-server --install-extension mrkou47.thrift-syntax-support
# code-server --install-extension ppz.ppz
code-server --install-extension ryu1kn.partial-diff
code-server --install-extension steoates.autoimport
code-server --install-extension streetsidesoftware.code-spell-checker
code-server --install-extension wmaurer.change-case
code-server --install-extension njzy.stats-bar
code-server --install-extension shardulm94.trailing-spaces
code-server --install-extension saber2pr.file-git-history
code-server --install-extension oderwat.indent-rainbow
code-server --install-extension pbkit.vscode-pbkit

# vscode setting
echo '{
  "workbench.colorTheme":"Default Dark+",
  "extensions.autoCheckUpdates":false,
  "extensions.autoUpdate":false,
  "extensions.ignoreRecommendations":true,
  "workbench.startupEditor":"none",
  "editor.tabSize": 2,
  "security.workspace.trust.enabled": false,
  "update.mode": "none",
}' > ~/.local/share/code-server/User/settings.json

# env
echo "# code-server
export EXTENSIONS_GALLERY='{\"serviceUrl\":\"https://marketplace.visualstudio.com/_apis/public/gallery\"}' # https://coder.com/docs/code-server/latest/FAQ#how-do-i-use-my-own-extensions-marketplace
export CODESPACES='true' # Disable golang extension's welcome page. Check https://github.com/golang/vscode-go/issues/1246
alias code='code-server'
" >> ~/.zshrc
