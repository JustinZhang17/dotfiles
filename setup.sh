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

display "Install Curl"
sudo apt install -y curl

display "Install Guest Agent"
sudo apt install qemu-guest-agent
sudo systemctl enable qemu-guest-agent
sudo systemctl start qemu-guest-agent

display "Install uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

display "Install Ansible"
uv tool install --with-executables-from ansible-core ansible

display "Install Neovim"
sudo snap install --classic nvim

display "Configuring Nvchad"
sudo apt install -y ripgrep gcc make unzip

mkdir -p $HOME/.config
cp -r ./config/nvim $HOME/.config/

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

display "Install c++ complier"
sudo apt install -y g++

display "Install xClip (Clipboard)"
sudo apt install -y xclip

display "Install Rust/Cargo"
curl https://sh.rustup.rs -sSf | sh

display "Install Starship"
curl -sS https://starship.rs/install.sh | sh

display "Configuring Starship"
cp -r ./config/starship/starship.toml $HOME/.config/

display "Generate SSH Key"
if [ -f $HOME/.ssh/id_ed25519.pub ]; then
  echo "SSH key already exists. Skipping key generation."
else
  ssh-keygen -t ed25519 -C "hi@justinjzhang.com"
fi

display "Clean unused packages"
sudo apt -y autoremove

display "Reload Shell Config"
source $SHELL_CONFIG
