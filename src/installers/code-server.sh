#!/usr/bin/env zsh
set -e

ARCH=$(arch)
if [ $ARCH = "x86_64" ]; then
  ARCH="amd64"
else
  ARCH="arm64"
fi

CODE_SERVER_VERSION=4.105.1
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

# Rename code-server to code
if [ -f /usr/lib/code-server/lib/vscode/bin/remote-cli/code-server ]; then
  mv /usr/lib/code-server/lib/vscode/bin/remote-cli/code-server /usr/lib/code-server/lib/vscode/bin/remote-cli/code
fi
