#!/bin/bash

set -e

print_subtitle "Setup applications"
PACKAGES_CONF="$SETUP_DIR/packages.conf"




# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

if [ ! -f "$PACKAGES_CONF" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source "$PACKAGES_CONF"

if isMacOS; then
  print_task "Installing system utilities"
  install_packages_mac "${SYSTEM_UTILS[@]}"
  print_task_done

  print_task "Installing dev tools"
  install_packages_mac "${DEV_TOOLS[@]}"
  install_packages_mac_casks "${DEV_TOOLS_CASKS[@]}"
  print_task_done

  print_task "Installing Tmux Plugin Manager (TPM)"
  if ! is_installed "tmux"; then
    echo "tmux is not installed."
    exit 1
  fi

  TPM_DIR="$HOME/.tmux/plugins/tpm"

  if [ ! -d "$TPM_DIR" ]; then
    print_subtask "Downloading source Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm $TPM_DIR
  fi
  print_task_done

  print_task "Installing browsers"
  install_packages_mac_casks "${BROWSERS[@]}"
  print_task_done

  print_task "Installing media packages"
  install_packages_mac_casks "${MEDIA[@]}"
  print_task_done

  print_task "Installing fonts"
  install_packages_mac_casks "${FONTS[@]}"
  print_task_done

  print_task "Installing Mac-only casks"
  install_packages_mac_casks "${MAC_ONLY_CASKS[@]}"
  print_task_done
fi
