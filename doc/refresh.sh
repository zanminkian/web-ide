#!/usr/bin/env bash
# set -ex

mkdir -p $HOME/web-ide-root/projects

docker stop web-ide
docker container rm -v web-ide
docker run -itd \
  --network host \
  -e PASSWORD="MY_PASSWORD" \
  -e WI_SSH_ID_ED25519_PUB="MY_PUBLIC_KEY" \
  -e WI_SSH_ID_ED25519="MY_PRIVATE_KEY" \
  -e WI_SSH_KEYSCAN="github.com" \
  -e WI_GIT_CONFIG="[user]\n\tname = zanminkian\n\temail = hellozmj@qq.com\n[safe]\n\tdirectory = *\n" \
  -e WI_INIT_CMD="echo 'registry=https://registry.npmmirror.com' >> ~/.npmrc; echo 'HISTFILE=~/projects/.zsh_history' >> ~/.zshrc" \
  -v $HOME/web-ide-root/projects:/home/web-ide/projects \
  --restart always \
  --name web-ide \
  zengmingjian/web-ide:0.28.3

echo '============================='
docker ps -a
echo '============================='
