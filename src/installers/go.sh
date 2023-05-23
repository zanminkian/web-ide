#!/usr/bin/env zsh
set -e

wget https://github.com/voidint/g/releases/download/v1.5.0/g1.5.0.linux-amd64.tar.gz -P /usr/local/bin
tar -xf /usr/local/bin/g1.5.0.linux-amd64.tar.gz -C /usr/local/bin
rm -rf /usr/local/bin/g1.5.0.linux-amd64.tar.gz
mv /usr/local/bin/g /usr/local/bin/gvm

gvm install 1.19.4
"${HOME}/.g/go/bin/go" install -v golang.org/x/tools/gopls@v0.11.0
"${HOME}/.g/go/bin/go" install -v github.com/go-delve/delve/cmd/dlv@v1.20.1
"${HOME}/.g/go/bin/go" install -v honnef.co/go/tools/cmd/staticcheck@v0.4.3

echo '# go
export G_MIRROR=https://golang.google.cn/dl/
export PATH="${HOME}/.g/go/bin:$PATH"
export GOROOT="${HOME}/.g/go"
export GOPATH="${HOME}/go"
export GO111MODULE="on"
export GOPROXY="https://goproxy.cn,direct"
' >> ~/.zshrc