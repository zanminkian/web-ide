#!/bin/sh
set -e

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found, installing..."
  curl -fLsS https://get.docker.com/ | sh
else
  echo "Docker is already installed, skipping installation."
fi

VERSION=$(node -e 'console.log(require("./package.json").version)')

docker buildx create --use --name mybuilder
docker buildx inspect mybuilder --bootstrap

docker buildx build --build-arg VERSION=$VERSION --platform linux/amd64 --load -f src/Dockerfile -t zengmingjian/web-ide:$NPM_CONFIG_TAG -t zengmingjian/web-ide:$VERSION src
docker images -a
docker save zengmingjian/web-ide:$VERSION | gzip > web-ide-$VERSION-linux-amd64.tgz
docker image rm zengmingjian/web-ide:$VERSION

docker buildx build --build-arg VERSION=$VERSION --platform linux/arm64 --load -f src/Dockerfile -t zengmingjian/web-ide:$NPM_CONFIG_TAG -t zengmingjian/web-ide:$VERSION src
docker images -a
docker save zengmingjian/web-ide:$VERSION | gzip > web-ide-$VERSION-linux-arm64.tgz
docker image rm zengmingjian/web-ide:$VERSION

ls -alh
mkdir assets
mv web-ide-$VERSION-linux-amd64.tgz assets
mv web-ide-$VERSION-linux-arm64.tgz assets
