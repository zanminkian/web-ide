#!/usr/bin/env zsh

TARGET_DIR=$(cd "$(dirname "$0")"; pwd)/installers
for file in $TARGET_DIR/*.installer.sh; do
  echo "[$(arch)]executing: $file"
  $file || { echo "[$(arch)]execute fail: $file" && exit 1; }
  echo "[$(arch)]executed: $file"
done
