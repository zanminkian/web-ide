#!/usr/bin/env zsh
set -e

# install something which will be remove in the future
apt update
export DEBIAN_FRONTEND=noninteractive && apt install -y krb5-user