#!/bin/sh
./build.sh
echo "build success!"
docker push -a zengmingjian/web-ide
