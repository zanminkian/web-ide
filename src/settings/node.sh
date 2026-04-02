#!/usr/bin/env zsh
set -e

# Get maintaining LTS versions (from newest to oldest)
get_maintaining_lts_versions() {
  local current_date=$(date +%Y-%m-%d)

  curl -s https://raw.githubusercontent.com/nodejs/Release/main/schedule.json | \
  awk -v current_date="$current_date" '
  /"v[0-9]+"/ {
    # Extract version number
    match($0, /"v([0-9]+)"/)
    version = substr($0, RSTART+2, RLENGTH-3)
    in_version = 1
    lts = ""
    end = ""
    next
  }

  in_version && /"lts":/ {
    # Extract lts date
    match($0, /"lts": "([^"]+)"/)
    lts = substr($0, RSTART+8, RLENGTH-9)
  }

  in_version && /"end":/ {
    # Extract end date
    match($0, /"end": "([^"]+)"/)
    end = substr($0, RSTART+8, RLENGTH-9)
  }

  in_version && /^  \}/ {
    # End of version block
    if (lts != "" && lts <= current_date && end > current_date) {
      print version
    }
    in_version = 0
  }
  ' | sort -rn
}

# Get and install all maintaining LTS versions
lts_versions=($(get_maintaining_lts_versions))
echo "Detected maintaining LTS versions: ${lts_versions[@]}"

eval "$(jrm env)"

# Install each version
for version in "${lts_versions[@]}"; do
  echo "Installing Node.js $version..."
  jrm install node@$version
done

# Configure each installed version (in reverse order, from oldest to newest)
for version in "${(Oa)lts_versions[@]}"; do
  echo "Configuring Node.js $version..."
  jrm use node@$version
  npm i -g @rnm/pm
  pm-util enable-shim
done

# TODO: Remove this if this [issue](https://github.com/pnpm/pnpm/issues/5803) is solved.
# Refer: https://github.com/pnpm/pnpm/issues/7024#issuecomment-1740740451.
# Another solution: https://github.com/pnpm/pnpm/issues/5803#issuecomment-2710571371.
mkdir -p ~/.config/pnpm
echo 'package-import-method=clone-or-copy' >> ~/.config/pnpm/rc

echo '# node
eval "$(jrm env)"
' >> ~/.zshrc

if which code >/dev/null 2>&1; then
  code --install-extension bradlc.vscode-tailwindcss
  # code --install-extension formulahendry.auto-rename-tag # Prefer enabling vscode built-in conifg `editor.linkedEditing`
fi

# Install some useful tools
# @arethetypeswrong/cli loadtest cloc pm2 npm-check-updates tree-cli del-cli
npm i -g http-server
npm i -g npm-check-updates
npm i -g fenge
npm i -g @rnm/gpp

# Install & configure Claude Code
echo '{"autoInstallIdeExtension":false,"hasCompletedOnboarding":true}' > ~/.claude.json
npm i -g @anthropic-ai/claude-code
