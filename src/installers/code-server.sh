#!/usr/bin/env zsh
set -e

CODE_SERVER_VERSION=4.13.0
wget https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb
dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb
rm -rf code-server_${CODE_SERVER_VERSION}_amd64.deb

# Lock extensions' version once https://github.com/microsoft/vscode/issues/172917 has been resolved.
export EXTENSIONS_GALLERY='{"serviceUrl":"https://marketplace.visualstudio.com/_apis/public/gallery"}'
code-server --install-extension GraphQL.vscode-graphql-syntax
code-server --install-extension IronGeek.vscode-env
code-server --install-extension christian-kohler.path-intellisense
code-server --install-extension golang.Go@0.38.0
code-server --install-extension humao.rest-client@0.25.1 # hard to use. change to httpYac one day
code-server --install-extension mhutchie.git-graph@1.30.0
code-server --install-extension mrkou47.thrift-syntax-support
code-server --install-extension ryu1kn.partial-diff@1.4.3
code-server --install-extension steoates.autoimport # hard to use. remove it one day
code-server --install-extension streetsidesoftware.code-spell-checker
code-server --install-extension wmaurer.change-case
code-server --install-extension njzy.stats-bar
code-server --install-extension shardulm94.trailing-spaces
code-server --install-extension oderwat.indent-rainbow
code-server --install-extension pbkit.vscode-pbkit
code-server --install-extension usernamehw.errorlens
code-server --install-extension wwm.better-align
# code-server --install-extension ppz.ppz # some error logs appear
# code-server --install-extension saber2pr.file-git-history # Vscode has integrated time-line. It's unnecessary.

# vscode setting
echo '{
  // extension
  "extensions.autoCheckUpdates": false,
  "extensions.autoUpdate": false,
  // workbench
  "workbench.startupEditor": "none",
  "workbench.colorTheme": "Default Dark Modern",
  // editor
  "editor.guides.bracketPairs": "active",
  "editor.renderWhitespace": "all",
  "editor.tabSize": 2,
  // other
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
