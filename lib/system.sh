#!/bin/bash

install_system_packages() {
  display "Update Package List"
  sudo apt-get update

  display "Install Core Packages"
  ensure_apt curl
  ensure_apt stow

  display "Install Guest Agent"
  ensure_apt qemu-guest-agent
  if dpkg -s qemu-guest-agent 2>/dev/null | grep -q '^Status: install ok installed$'; then
    sudo systemctl enable qemu-guest-agent
    sudo systemctl start qemu-guest-agent
  fi

  display "Install Neovim Dependencies"
  ensure_apt ripgrep
  ensure_apt gcc
  ensure_apt make
  ensure_apt unzip
  ensure_apt build-essential
  ensure_apt libc6-dev
  ensure_apt libclang-dev

  display "Install System Packages"
  ensure_apt git
  ensure_apt git-delta
  ensure_apt sxiv
  ensure_apt bat
  ensure_apt btop
  ensure_apt bison
  ensure_apt zathura
  ensure_apt g++
  ensure_apt xclip

  display "Install Snap Packages"
  ensure_snap nvim nvim
  ensure_snap typst typst
  ensure_snap gh gh classic
}
