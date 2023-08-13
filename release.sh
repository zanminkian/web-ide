#!/bin/sh
curl -fLsS https://get.docker.com/ | sh

TAG_NAME=$(node -e 'console.log(require("./package.json").version)')
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -f src/Dockerfile -t zengmingjian/web-ide:latest -t zengmingjian/web-ide:$TAG_NAME .
docker push -a zengmingjian/web-ide
