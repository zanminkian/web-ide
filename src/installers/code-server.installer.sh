#!/usr/bin/env zsh
set -e

ARCH=$(arch)
if [ $ARCH = "x86_64" ]; then
  ARCH="amd64"
else
  ARCH="arm64"
fi

CODE_SERVER_VERSION=4.101.2
curl -L https://github.com/coder/code-server/releases/download/v$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-$ARCH.tar.gz -o /usr/lib/code-server.tgz
tar -xf /usr/lib/code-server.tgz -C /usr/lib
rm -rf /usr/lib/code-server.tgz
mv /usr/lib/code-server-$CODE_SERVER_VERSION-linux-$ARCH /usr/lib/code-server
# Custom marketplace. Refer https://coder.com/docs/code-server/latest/FAQ#how-do-i-use-my-own-extensions-marketplace.
echo "#!/usr/bin/env sh
if [ \"\$*\" = \"-v\" ] || [ \"\$*\" = \"--version\" ]; then
  echo \"Web-IDE v$VERSION\"
fi
EXTENSIONS_GALLERY='{\"serviceUrl\":\"https://marketplace.visualstudio.com/_apis/public/gallery\"}' /usr/lib/code-server/bin/code-server \"\$@\"
" > /usr/bin/code
chmod +x /usr/bin/code

# common
code --install-extension mhutchie.git-graph@1.30.0 # imperfect.
code --install-extension ryu1kn.partial-diff
code --install-extension christian-kohler.path-intellisense
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension wmaurer.change-case
code --install-extension shardulm94.trailing-spaces
code --install-extension wwm.better-align
code --install-extension njzy.stats-bar
code --install-extension humao.rest-client # imperfect
# syntax
code --install-extension GraphQL.vscode-graphql-syntax
code --install-extension pbkit.vscode-pbkit
code --install-extension mrkou47.thrift-syntax-support
# tools
code --install-extension hediet.vscode-drawio
# code --install-extension github.copilot
code --install-extension alibaba-cloud.tongyi-lingma # imperfect
# removed
# code --install-extension oderwat.indent-rainbow # not significant
# code --install-extension usernamehw.errorlens # too noisy
# code --install-extension ppz.ppz # some error logs appear
# code --install-extension steoates.autoimport # it seems that it have some bugs
# code --install-extension SantaCodes.santacodes-region-viewer # code 1.88 built-in support it
# code --install-extension formulahendry.code-runner
# code --install-extension IronGeek.vscode-env

# vscode setting
echo '{
  // editor
  "editor.linkedEditing": true,
  "editor.guides.bracketPairs": true,
  "editor.showFoldingControls": "always",
  "editor.renderWhitespace": "all",
  "editor.tabSize": 2,
  "editor.quickSuggestions": { // For tailwind extension. https://github.com/tailwindlabs/tailwindcss-intellisense
    "strings": "on"
  },
  // appearance
  "debug.toolBarLocation": "docked",
  "window.title": "${rootName}",
  "workbench.editor.pinnedTabsOnSeparateRow": true,
  "workbench.startupEditor": "none",
  // file readonly
  "files.readonlyFromPermissions": true,
  "files.readonlyInclude": {
    "**/{package-lock.json,pnpm-lock.yaml,yarn.lock}": true,
    "**/node_modules/**/*": true,
    "**/go.sum": true,
  },
  // language
  "javascript.inlayHints.parameterNames.enabled": "all",
  "typescript.inlayHints.parameterNames.enabled": "all",
  // security
  "security.workspace.trust.enabled": false,
  // update
  "extensions.autoCheckUpdates": false,
  "extensions.autoUpdate": false,
  "update.mode": "none",
  // third-party
  "cSpell.diagnosticLevel": "Hint",
  "rest-client.rememberCookiesForSubsequentRequests": false,
  "Lingma.methodQuickOperation": false,
}' > ~/.local/share/code-server/User/settings.json

# code-server config
sed -i '/^bind-addr:/d' ~/.config/code-server/config.yaml
echo 'bind-addr: 0.0.0.0:8080' >> ~/.config/code-server/config.yaml
sed -i '/^disable-update-check:/d' ~/.config/code-server/config.yaml
echo 'disable-update-check: true' >> ~/.config/code-server/config.yaml
