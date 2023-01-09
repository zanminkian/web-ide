#!/usr/bin/env zsh
touch ~/.zshrc
mv ~/.zshrc ~/.zshrc_tmp

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
. ~/.zshrc
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
omz plugin enable zsh-autosuggestions zsh-syntax-highlighting

cat ~/.zshrc_tmp >> ~/.zshrc
rm -rf ~/.zshrc_tmp
