#!/usr/bin/env zsh
set -e

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

cp ~/.oh-my-zsh/themes/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/simple-robbyrussell.zsh-theme
sed -i 's/%c/%~/' ~/.oh-my-zsh/themes/simple-robbyrussell.zsh-theme
sed -i 's/git://' ~/.oh-my-zsh/themes/simple-robbyrussell.zsh-theme

echo '# omz
export ZSH="$HOME/.oh-my-zsh"
DISABLE_AUTO_UPDATE="true" # https://stackoverflow.com/questions/11378607/oh-my-zsh-disable-would-you-like-to-check-for-updates-prompt
ZSH_THEME="simple-robbyrussell"
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
' >> ~/.zshrc
