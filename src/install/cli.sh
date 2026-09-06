#!/usr/bin/env zsh
set -e

# Install ttyd
# curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 -o /usr/local/bin/ttyd
# chmod +x /usr/local/bin/ttyd

# Install tools via apt
# apt install --no-install-recommends -y mysql-client
# apt install --no-install-recommends -y redis-tools

# Install essential libs
# `build-essential` is required for some c/c++ libraries. Some Node projects (like some sub-libs of midway.js) using c++ needs this.
apt install --no-install-recommends -y build-essential

# Install fd and ripgrep so Pi can find files and search file contents without downloading them at runtime.
apt install --no-install-recommends -y fd-find ripgrep
ln -s $(which fdfind) /usr/bin/fd
