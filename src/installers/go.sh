#!/usr/bin/env zsh
set -e

curl -L https://github.com/voidint/g/releases/download/v1.5.1/g1.5.1.linux-amd64.tar.gz -o /usr/local/bin/g1.5.1.linux-amd64.tar.gz
tar -xf /usr/local/bin/g1.5.1.linux-amd64.tar.gz -C /usr/local/bin
rm -rf /usr/local/bin/g1.5.1.linux-amd64.tar.gz
mv /usr/local/bin/g /usr/local/bin/gvm

gvm install 1.19.9
rm -rf $HOME/.g/downloads/* # clean something useless to decrease the image sise

# https://github.com/golang/vscode-go/wiki/tools
$HOME/.g/go/bin/go install golang.org/x/tools/gopls@v0.12.2
$HOME/.g/go/bin/go install github.com/go-delve/delve/cmd/dlv@v1.20.2
$HOME/.g/go/bin/go install honnef.co/go/tools/cmd/staticcheck@v0.4.3

echo '# go
export G_MIRROR=https://golang.google.cn/dl/
export GOROOT="$HOME/.g/go"
export GOPATH="$HOME/go"
export GO111MODULE="on"
export GOPROXY="https://goproxy.cn,direct"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
' >> ~/.zshrc