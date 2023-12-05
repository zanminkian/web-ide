#!/bin/sh
curl -fLsS https://get.docker.com/ | sh

VERSION=$(node -e 'console.log(require("./package.json").version)')
TAG=$(node -e 'console.log(require("./package.json").version.match(/^[0-9]+\.[0-9]+\.[0-9]+-(.+)\.[0-9]+$/)?.[1] || "latest")')
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker buildx ls
docker build --platform linux/arm64 -f src/Dockerfile -t zengmingjian/web-ide:$TAG -t zengmingjian/web-ide:$VERSION src
docker images -a
docker push -a zengmingjian/web-ide
