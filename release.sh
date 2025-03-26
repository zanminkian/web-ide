#!/bin/sh
set -e
curl -fLsS https://get.docker.com/ | sh

VERSION=$(node -e 'console.log(require("./package.json").version)')
TAG=$(node -e 'console.log(require("./package.json").version.match(/^[0-9]+\.[0-9]+\.[0-9]+-(.+)\.[0-9]+$/)?.[1] || "latest")')

docker buildx create --use --name mybuilder
docker buildx inspect mybuilder --bootstrap
docker buildx build --build-arg VERSION=$VERSION --platform linux/amd64 -o type=tar,dest=- -f src/Dockerfile -t zengmingjian/web-ide:$TAG -t zengmingjian/web-ide:$VERSION src | gzip > web-ide-$VERSION-linux-amd64.tgz
ls -alh
docker buildx build --build-arg VERSION=$VERSION --platform linux/arm64 -o type=tar,dest=- -f src/Dockerfile -t zengmingjian/web-ide:$TAG -t zengmingjian/web-ide:$VERSION src | gzip > web-ide-$VERSION-linux-arm64.tgz
ls -alh

mkdir assets
mv web-ide-$VERSION-linux-amd64.tgz assets
mv web-ide-$VERSION-linux-arm64.tgz assets
