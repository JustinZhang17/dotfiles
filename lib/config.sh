#!/bin/bash

prepare_target() {
  local target="$1"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    confirm "Replace existing $target with stow symlink?" || return 1
    rm -rf "$target"
  fi

  return 0
}

stow_configs() {
  display "Stow Dotfiles"
  local stow_dir
  stow_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

  if command -v stow >/dev/null 2>&1; then
    mkdir -p "$HOME/.config"

    local dir
    for dir in "$HOME/.config/nvim" "$HOME/.config/opencode" "$HOME/.config/starship" "$HOME/.config/tmux"; do
      prepare_target "$dir" || continue
    done

    local file
    for file in "$HOME/.config/starship.toml" "$HOME/.config/rc" "$HOME/.gitconfig"; do
      prepare_target "$file" || continue
    done

    stow --restow -d "$stow_dir" -t "$HOME/.config" config
    stow --restow -d "$stow_dir" -t "$HOME" git
  else
    warn "Skipping stow (stow is not installed)"
  fi
}

configure_system() {
  stow_configs

  display "Configuring Shell Commands"
  local shell_config
  case "$(basename "${SHELL:-/bin/bash}")" in
    zsh) shell_config="$HOME/.zshrc" ;;
    *) shell_config="$HOME/.bashrc" ;;
  esac

  local rc_file
  for rc_file in "$HOME/.bashrc" "$HOME/.zshrc"; do
    [ -f "$rc_file" ] || continue

    local needs_update=false
    if grep -q '^# RC config$' "$rc_file"; then
      needs_update=true
    fi
    if ! grep -qF 'source "$HOME/.config/rc"' "$rc_file"; then
      needs_update=true
    fi
    [ "$needs_update" = true ] || continue

    [ -f "$rc_file.bak" ] || cp "$rc_file" "$rc_file.bak"
    awk '/^# RC config$/ { skip = 1; next } skip && /^fi$/ { skip = 0; next } !skip' "$rc_file" > "$rc_file.tmp"
    if ! grep -qF 'source "$HOME/.config/rc"' "$rc_file.tmp"; then
      echo "" >> "$rc_file.tmp"
      echo '[ -f "$HOME/.config/rc" ] && source "$HOME/.config/rc"' >> "$rc_file.tmp"
    fi
    mv "$rc_file.tmp" "$rc_file"
  done

  display "Generate SSH Key"
  if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
    echo "SSH key already exists. Skipping key generation."
  else
    ssh-keygen -t ed25519 -C "hi@justinjzhang.com"
  fi

  display "Login + Add SSH Auth pub key to Github"
  if command -v gh >/dev/null 2>&1; then
    if ! gh auth status >/dev/null 2>&1; then
      gh auth login -h github.com -s admin:ssh_signing_key
    fi

    display "Add SSH Signing Key to Github"
    if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
      gh ssh-key add "$HOME/.ssh/id_ed25519.pub" --type signing || warn "Failed to add SSH signing key (it may already exist)"
    else
      warn "Skipping SSH signing key (public key not found)"
    fi
  else
    warn "Skipping GitHub CLI setup (gh is not installed)"
  fi

  display "Set EST Timezone"
  sudo timedatectl set-timezone EST

  display "Clean unused packages"
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y autoremove

  display "Reload Shell Config"
  display "Restart your shell or run: source $shell_config"
}
