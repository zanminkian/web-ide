#!/usr/bin/env bash
# set -ex

mkdir -p $HOME/web-ide-root/projects $HOME/web-ide-root/go/src
touch $HOME/web-ide-root/.zsh_history

docker stop web-ide
docker container rm -v web-ide
docker run -itd \
  --network host \
  -e PASSWORD="MY_PASSWORD" \
  -e WI_SSH_ID_ED25519_PUB="MY_PUBLICK_KEY" \
  -e WI_SSH_ID_ED25519="MY_PRIVATE_KEY" \
  -e WI_SSH_KEYSCAN="github.com" \
  -e WI_GIT_CONFIG="[user]\n\tname = zanminkian\n\temail = hellozmj@qq.com\n[safe]\n\tdirectory = *\n" \
  -e WI_INIT_CMD="echo 'registry=https://registry.npmmirror.com' >> ~/.npmrc" \
  -v $HOME/web-ide-root/projects:/root/projects \
  -v $HOME/web-ide-root/go/src:/root/go/src \
  -v $HOME/web-ide-root/.zsh_history:/root/.zsh_history \
  --restart always \
  --name web-ide \
  zengmingjian/web-ide

echo '============================='
docker ps -a
echo '============================='
