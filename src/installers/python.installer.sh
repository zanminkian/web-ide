#!/usr/bin/env zsh
set -e

echo "python: install begin. $(arch)"

apt update
apt install -y python3 python-is-python3

echo "python: install success. $(arch)"
