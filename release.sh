#!/bin/sh
curl -fLsS https://get.docker.com/ | sh

VERSION=$(node -e 'console.log(require("./package.json").version)')
TAG=$(node -e 'console.log(require("./package.json").version.match(/^[0-9]+\.[0-9]+\.[0-9]+-(.+)\.[0-9]+$/)?.[1] || "latest")')
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -f src/Dockerfile --platform linux/amd64,linux/arm64/v8 -t zengmingjian/web-ide:$TAG -t zengmingjian/web-ide:$VERSION src
docker images -a
docker push -a zengmingjian/web-ide
