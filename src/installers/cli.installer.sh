#!/usr/bin/env zsh
set -e

# Install ttyd
# curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd
# chmod +x /usr/local/bin/ttyd

# Install tools via apt
# apt install -y mysql-client
apt install -y redis-tools

# `build-essential` is required for some c/c++ libraries. Some Node projects (like some sub-libs of midway.js) using c++ needs this.
# Others libs are required when building electron app. Refer to https://github.com/electron/forge/blob/35e7b9cd58cf0923dde58f94f477b09b5597f5ae/.circleci/config.yml#L152
apt install -y --no-install-recommends \
    build-essential \
    libgtk-3-0 \
    libnss3 \
    libgbm1 \
    libasound2
