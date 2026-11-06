#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT_DIR/lib/common.sh"
source "$ROOT_DIR/lib/system.sh"
source "$ROOT_DIR/lib/tools.sh"
source "$ROOT_DIR/lib/config.sh"

UPDATE_ONLY=false
case "${1:-}" in
  --update) UPDATE_ONLY=true ;;
  "") ;;
  *) die "Usage: $0 [--update]" ;;
esac

check_distro

if [ "$UPDATE_ONLY" = true ]; then
  stow_configs
else
  install_system_packages
  install_tools
  configure_system
fi
