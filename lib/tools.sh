#!/bin/bash

install_rustup() {
  curl https://sh.rustup.rs -sSf | sh
  if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
  fi
}

install_uv() {
  curl -LsSf https://astral.sh/uv/install.sh | sh
}

install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
}

load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
  fi
  if [ -s "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/bash_completion"
  fi
}

install_gvm() {
  curl -fsSL gvm.run/install.sh | bash
  if [ -d "$HOME/bin" ]; then
    mkdir -p "$HOME/.local/bin"
    mv "$HOME/bin/gvm" "$HOME/.local/bin/"
    rm -r "$HOME/bin/"
  fi
}

install_starship() {
  curl -sS https://starship.rs/install.sh | sh
}

install_tailscale() {
  curl -fsSL https://tailscale.com/install.sh | sh
}

install_docker() {
  sudo DEBIAN_FRONTEND=noninteractive apt-get remove -y docker docker-engine docker.io containerd runc || true
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker "$USER"
}

install_opencode() {
  curl -fsSL https://opencode.ai/install | bash
}

install_tree_sitter_cli() {
  local arch
  case "$(uname -m)" in
    x86_64) arch=x64 ;;
    aarch64|arm64) arch=arm64 ;;
    *) die "Unsupported architecture for tree-sitter-cli: $(uname -m)" ;;
  esac
  mkdir -p "$HOME/.local/bin"
  curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-${arch}.gz" | gunzip > "$HOME/.local/bin/tree-sitter"
  chmod +x "$HOME/.local/bin/tree-sitter"
}

install_miniserve() {
  local arch tag
  case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    aarch64|arm64) arch=aarch64 ;;
    *) die "Unsupported architecture for miniserve: $(uname -m)" ;;
  esac
  tag="$(curl -fsSL -o /dev/null -w '%{url_effective}' https://github.com/svenstaro/miniserve/releases/latest)"
  tag="${tag##*/}"
  download_binary "https://github.com/svenstaro/miniserve/releases/download/${tag}/miniserve-${tag#v}-${arch}-unknown-linux-gnu" "$HOME/.local/bin/miniserve"
}

install_tealdeer() {
  local arch
  case "$(uname -m)" in
    x86_64) arch=x86_64 ;;
    aarch64|arm64) arch=aarch64 ;;
    *) die "Unsupported architecture for tealdeer: $(uname -m)" ;;
  esac
  download_binary "https://github.com/tealdeer-rs/tealdeer/releases/latest/download/tealdeer-linux-${arch}-musl" "$HOME/.local/bin/tldr"
}

ensure_nvm() {
  export NVM_DIR="$HOME/.nvm"
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    display "Skipping nvm (already installed)"
    return 0
  fi

  confirm "Install nvm?" || { display "Skipping nvm"; return 0; }
  install_nvm
}

install_tools() {
  display "Install Rust/Cargo"
  ensure_command cargo "Rust/Cargo" install_rustup

  display "Install uv"
  ensure_command uv "uv" install_uv

  display "Install Ansible"
  ensure_command ansible "Ansible" uv tool install --with-executables-from ansible-core ansible

  display "Install tree-sitter-cli"
  ensure_command tree-sitter "tree-sitter-cli" install_tree_sitter_cli

  display "Setup nvm"
  ensure_nvm
  load_nvm

  display "Install Node"
  ensure_command node "Node" nvm install stable

  display "Install safe-rm"
  ensure_command safe-rm "safe-rm" npm i -g safe-rm

  display "Install pnpm"
  ensure_command pnpm "pnpm" npm i -g pnpm

  display "Install gvm"
  ensure_command gvm "gvm" install_gvm

  display "Install Starship"
  ensure_command starship "Starship" install_starship

  display "Install Tailscale"
  ensure_command tailscale "Tailscale" install_tailscale

  display "Install Docker"
  ensure_command docker "Docker" install_docker

  display "Install Opencode"
  ensure_command opencode "Opencode" install_opencode

  display "Install miniserve"
  ensure_command miniserve "miniserve" install_miniserve

  display "Install tldr"
  ensure_command tldr "tldr" install_tealdeer
}
