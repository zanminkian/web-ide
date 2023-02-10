#!/usr/bin/env zsh

set -ex

wget https://github.com/voidint/g/releases/download/v1.3.0/g1.3.0.linux-amd64.tar.gz -P /usr/local/bin
tar -xf /usr/local/bin/g1.3.0.linux-amd64.tar.gz -C /usr/local/bin
rm -rf /usr/local/bin/g1.3.0.linux-amd64.tar.gz

echo '\n# go' >> ~/.zshrc
echo 'export G_MIRROR=https://golang.google.cn/dl/' >> ~/.zshrc
echo 'export PATH="${HOME}/.g/go/bin:$PATH"' >> ~/.zshrc
echo 'export GOROOT="${HOME}/.g/go"' >> ~/.zshrc
echo 'export GOPATH="${HOME}/go"' >> ~/.zshrc
echo 'export GO111MODULE="on"' >> ~/.zshrc
echo 'export GOPROXY="https://goproxy.cn,direct"' >> ~/.zshrc

/usr/local/bin/g install 1.19.4
. ~/.zshrc

go install -v golang.org/x/tools/gopls@latest
go install -v github.com/go-delve/delve/cmd/dlv@latest
go install -v honnef.co/go/tools/cmd/staticcheck@latest
