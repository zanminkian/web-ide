#!/usr/bin/env zsh

set -ex

touch ~/.zshrc
mv ~/.zshrc ~/.zshrc_tmp

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

rm -rf ~/.zshrc
echo '\n# omz' >> ~/.zshrc
echo 'export ZSH="$HOME/.oh-my-zsh"' >> ~/.zshrc
echo 'export DISABLE_AUTO_UPDATE="true"' >> ~/.zshrc
echo 'ZSH_THEME="robbyrussell"' >> ~/.zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc
echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc

cat ~/.zshrc_tmp >> ~/.zshrc
rm -rf ~/.zshrc_tmp
