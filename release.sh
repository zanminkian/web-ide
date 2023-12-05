#!/bin/sh
curl -fLsS https://get.docker.com/ | sh

VERSION=$(node -e 'console.log(require("./package.json").version)')
TAG=$(node -e 'console.log(require("./package.json").version.match(/^[0-9]+\.[0-9]+\.[0-9]+-(.+)\.[0-9]+$/)?.[1] || "latest")')
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker buildx ls
docker buildx create --use --name mybuilder
docker buildx inspect mybuilder --bootstrap
docker buildx ls
docker buildx build --platform linux/amd64,linux/arm64 --push -f src/Dockerfile -t zengmingjian/web-ide:$TAG -t zengmingjian/web-ide:$VERSION src
