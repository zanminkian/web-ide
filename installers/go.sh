#!/usr/bin/env zsh

set -e

wget https://github.com/voidint/g/releases/download/v1.3.0/g1.3.0.linux-amd64.tar.gz -P /usr/local/bin
tar -xf /usr/local/bin/g1.3.0.linux-amd64.tar.gz -C /usr/local/bin
rm -rf /usr/local/bin/g1.3.0.linux-amd64.tar.gz

echo '# go
export G_MIRROR=https://golang.google.cn/dl/
export PATH="${HOME}/.g/go/bin:$PATH"
export GOROOT="${HOME}/.g/go"
export GOPATH="${HOME}/go"
export GO111MODULE="on"
export GOPROXY="https://goproxy.cn,direct"
' >> ~/.zshrc

/usr/local/bin/g install 1.19.4
. ~/.zshrc

go install -v golang.org/x/tools/gopls@latest
go install -v github.com/go-delve/delve/cmd/dlv@latest
go install -v honnef.co/go/tools/cmd/staticcheck@latest
