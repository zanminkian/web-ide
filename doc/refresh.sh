#!/usr/bin/env bash
# set -ex

mkdir -p $HOME/web-ide-root/projects

LATEST_VERSION=$(docker images zengmingjian/web-ide --format "table {{.Tag}}" | grep -v "TAG" | grep -v "latest" | sort -V | tail -1)
if [ -z "$LATEST_VERSION" ]; then
  echo "Error: No zengmingjian/web-ide image found locally. Please pull or load the image first."
  exit 1
fi
echo "Using image version: $LATEST_VERSION"

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
  zengmingjian/web-ide:$LATEST_VERSION

echo '============================='
docker ps -a
echo '============================='
