#!/bin/sh
set -e

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found, installing..."
  curl -fLsS https://get.docker.com/ | sh
else
  echo "Docker is already installed, skipping installation."
fi

VERSION=$(node -e 'console.log(require("./package.json").version)')

ARCH=$(uname -m)
case "$ARCH" in
  x86_64)  PLATFORM=linux/amd64; SUFFIX=amd64 ;;
  aarch64) PLATFORM=linux/arm64; SUFFIX=arm64 ;;
  *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
esac
echo "Building for $PLATFORM (host arch: $ARCH)"

docker buildx create --use --name mybuilder
docker buildx inspect mybuilder --bootstrap

docker buildx build --build-arg VERSION=$VERSION --platform $PLATFORM --load -f src/Dockerfile -t zengmingjian/web-ide:$VERSION src
docker images -a
docker save zengmingjian/web-ide:$VERSION | gzip > web-ide-$VERSION-linux-$SUFFIX.tgz
docker image rm zengmingjian/web-ide:$VERSION

ls -alh
mkdir -p assets
mv web-ide-$VERSION-linux-$SUFFIX.tgz assets
