#!/bin/bash

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.opencode/bin:$PATH"

display() {
  echo -e "\e[1;32m$@\e[0m"
}

warn() {
  echo -e "\e[1;33m$@\e[0m"
}

die() {
  echo -e "\e[1;31m$@\e[0m" >&2
  exit 1
}

confirm() {
  local reply
  read -r -p "$1 [y/N] " reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

check_distro() {
  [ "$(uname -s)" = "Linux" ] || die "This script only supports Linux."

  [ -f /etc/os-release ] || die "Cannot detect distro: /etc/os-release not found."
  . /etc/os-release

  case " ${ID:-} ${ID_LIKE:-} " in
    *debian*|*ubuntu*) ;;
    *) die "Only Debian/Ubuntu based distros are supported (found: ${ID:-unknown})." ;;
  esac

  command -v apt-get >/dev/null 2>&1 || die "apt-get not found. Only Debian/Ubuntu based distros are supported."
}

ensure_apt() {
  local pkg="$1"

  if dpkg -s "$pkg" 2>/dev/null | grep -q '^Status: install ok installed$'; then
    display "Skipping $pkg (already installed)"
    return 0
  fi

  confirm "Install $pkg?" || { display "Skipping $pkg"; return 0; }
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$pkg"
}

ensure_snap() {
  local pkg="$1"
  local cmd="${2:-$pkg}"
  local classic="${3:-}"

  if ! command -v snap >/dev/null 2>&1; then
    warn "Skipping $pkg (snap is not installed)"
    return 0
  fi

  if snap list "$pkg" >/dev/null 2>&1 || command -v "$cmd" >/dev/null 2>&1; then
    display "Skipping $pkg (already installed)"
    return 0
  fi

  confirm "Install $pkg?" || { display "Skipping $pkg"; return 0; }
  if [ -n "$classic" ]; then
    sudo snap install --classic "$pkg"
  else
    sudo snap install "$pkg"
  fi
}

download_binary() {
  local url="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  curl -fsSL "$url" -o "$dest.tmp"
  chmod +x "$dest.tmp"
  mv "$dest.tmp" "$dest"
}

ensure_command() {
  local cmd="$1"
  local label="$2"
  shift 2

  if command -v "$cmd" >/dev/null 2>&1; then
    display "Skipping $label (already installed)"
    return 0
  fi

  confirm "Install $label?" || { display "Skipping $label"; return 0; }
  "$@"
}
