#!/usr/bin/env zsh
set -e

# install jrm
curl -L "https://github.com/rnmjs/jrm/releases/latest/download/jrm-$(uname -s)-$(uname -m)" -o /usr/local/bin/jrm
chmod +x /usr/local/bin/jrm
