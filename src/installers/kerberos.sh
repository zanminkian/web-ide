#!/usr/bin/env zsh
set -e

apt update
export DEBIAN_FRONTEND=noninteractive && apt install -y krb5-user
