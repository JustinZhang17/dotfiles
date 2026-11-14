#!/bin/bash

# Learning folder env that deletes top level dirs after 60 days of staleness
setup_sandbox() {
  display "Setup Sandbox"

  if [ ! -d "$HOME/sandbox" ]; then
    confirm "Create sandbox directory at $HOME/sandbox?" || { warn "Skipping sandbox setup"; return 0; }
    mkdir -p "$HOME/sandbox"
  fi

  chmod +x "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/bin/sandbox-cleanup"

  if ! command -v systemctl >/dev/null 2>&1; then
    warn "Skipping sandbox cleanup timer (systemd not available)"
    return 0
  fi

  if ! systemctl --user daemon-reload; then
    warn "Skipping sandbox cleanup timer (no user systemd session)"
    return 0
  fi
  systemctl --user enable --now sandbox-cleanup.timer || warn "Could not enable sandbox-cleanup.timer"
}
