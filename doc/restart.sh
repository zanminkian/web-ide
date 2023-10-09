#!/usr/bin/env bash
#set -ex

mkdir -p $HOME/web-ide-root/projects $HOME/web-ide-root/go/src
touch $HOME/web-ide-root/.zsh_history

docker pull zengmingjian/web-ide
docker stop web-ide
docker container rm -v web-ide
docker run -itd \
  -p 3000:3000 \
  -p 8080:8080 \
  -e PASSWORD="MY_PASSWORD" \
  -e SSH_ID_ED25519_PUB="MY_PUBLICK_KEY" \
  -e SSH_ID_ED25519="MY_PRIVATE_KEY" \
  -e SSH_KEYSCAN="github.com" \
  -e GIT_CONFIG="[user]\n\tname = zanminkian\n\temail = hellozmj@qq.com\n" \
  -e WEB_IDE_INIT_CMD="sed -i 's/Default Dark Modern/Default Dark\+/g' /root/.local/share/code-server/User/settings.json" \
  -v $HOME/web-ide-root/projects:/root/projects \
  -v $HOME/web-ide-root/go/src:/root/go/src \
  -v $HOME/web-ide-root/.zsh_history:/root/.zsh_history \
  --name web-ide \
  zengmingjian/web-ide

echo '============================='
docker ps -a
echo '============================='
