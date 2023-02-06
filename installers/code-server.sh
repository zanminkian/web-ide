#!/usr/bin/env zsh

CODE_SERVER_VERSION=4.9.1
curl -L https://github.com/coder/code-server/releases/download/v$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz -o /usr/lib/code-server.tgz
tar -xzf /usr/lib/code-server.tgz -C /usr/lib
mv /usr/lib/code-server-$CODE_SERVER_VERSION-linux-amd64 /usr/lib/code-server
rm -rf /usr/lib/code-server.tgz

CODE_SERVER_HOME=/usr/lib/code-server
export EXTENSIONS_GALLERY='{"serviceUrl":"https://marketplace.visualstudio.com/_apis/public/gallery"}'
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension GraphQL.vscode-graphql-syntax
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension IronGeek.vscode-env
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension christian-kohler.path-intellisense
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension esbenp.prettier-vscode
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension golang.Go
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension humao.rest-client
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension mhutchie.git-graph
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension mrkou47.thrift-syntax-support
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension ppz.ppz
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension ryu1kn.partial-diff
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension steoates.autoimport
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension streetsidesoftware.code-spell-checker
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension wmaurer.change-case
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension njzy.stats-bar
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension shardulm94.trailing-spaces
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension saber2pr.file-git-history
$CODE_SERVER_HOME/lib/node $CODE_SERVER_HOME --install-extension oderwat.indent-rainbow

# vscode setting
echo '{"workbench.colorTheme":"Default Dark+","extensions.autoCheckUpdates":false,"extensions.autoUpdate":false,"extensions.ignoreRecommendations":true,"workbench.startupEditor":"none"}' > ~/.local/share/code-server/User/settings.json

# code-server config
echo 'bind-addr: 0.0.0.0:8080' > ~/.config/code-server/config.yaml
echo 'auth: password' >> ~/.config/code-server/config.yaml
echo 'password: default' >> ~/.config/code-server/config.yaml
echo 'cert: false' >> ~/.config/code-server/config.yaml
echo 'disable-update-check: true' >> ~/.config/code-server/config.yaml
echo 'disable-getting-started-override: true' >> ~/.config/code-server/config.yaml
echo 'disable-workspace-trust: true' >> ~/.config/code-server/config.yaml
echo 'disable-telemetry: true' >> ~/.config/code-server/config.yaml

# env
echo '\n# code-server' >> ~/.zshrc
echo "export EXTENSIONS_GALLERY='{\"serviceUrl\":\"https://marketplace.visualstudio.com/_apis/public/gallery\"}'" >> ~/.zshrc # https://coder.com/docs/code-server/latest/FAQ#how-do-i-use-my-own-extensions-marketplace
echo 'export CODESPACES="true"' >>  ~/.zshrc # Disable golang extension's welcome page. Check https://github.com/golang/vscode-go/issues/1246
echo 'alias code="code-server"' >> ~/.zshrc

