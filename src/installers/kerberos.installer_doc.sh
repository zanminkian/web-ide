#!/usr/bin/env zsh
set -e

export DEBIAN_FRONTEND=noninteractive && apt install --no-install-recommends -y krb5-user
