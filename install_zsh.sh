#!/bin/bash

#install zsh shell
sudo apt update && sudo apt-get install zsh -y

#install 'oh my zsh'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#list themes
ls ~/.oh-my-zsh/themes/

#plugins “ZSH-autosuggestions and ZSH-Syntax-highlighting”
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

#Update theme
sed -i 's/ZSH_THEME=[^ ]*/ZSH_THEME=ys/g' ~/.zshrc

#Add plugin
sed -i 's/plugins=\(.*\)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc