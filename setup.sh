#!/bin/bash

# NOTE: Only run on Debian/Ubuntu based distros
OS=$(uname -s)

if [[ "$OS" != "Linux" ]]; then
	exit 1
fi

# Detect shell and config file
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
else
    SHELL_CONFIG="$HOME/.bashrc"
fi

display() {
  echo -e "\e[1;32m$@\e[0m"
}

display "Update Package List"
sudo apt update

display "Install uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

display "Install Ansible"
uv tool install --with-executables-from ansible-core ansible

display "Install Neovim"
sudo snap install --classic nvim

display "Configuring Nvchad"
sudo apt install -y ripgrep gcc make

mkdir -p $HOME/.config
cp -r ./config/nvim $HOME/.config/nvim

display "Setup nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

display "Install Node"
nvm install stable

display "Install git"
sudo apt install -y git

display "Configuring git"
cp -r ./config/git/.gitconfig $HOME

display "Install Delta"
sudo apt install -y git-delta

display "Install Bat"
sudo apt install -y bat

display "Configuring Shell Commands"
if ! grep -qF "# RC config" "$SHELL_CONFIG"; then
  echo "" >> $SHELL_CONFIG
  cat ./config/rc >> $SHELL_CONFIG
fi
source $SHELL_CONFIG

display "Install safe-rm"
npm i -g safe-rm

display "Install gvm"
sudo apt install -y bison
curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
source $HOME/.gvm/scripts/gvm

display "Install Typst"
sudo snap install typst

display "Install Zathura"
sudo apt install -y zathura

display "Clean unused packages"
sudo apt -y autoremove
