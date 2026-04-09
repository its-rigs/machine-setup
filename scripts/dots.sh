#!/bin/bash

set -e

DOT_FILES_DIR="$SETUP_DIR/dots"

stow_config() {
  local package=$1
  print_task "$package"
  stow -d "$DOT_FILES_DIR" -t ~ "$package"
  print_task_done
}

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

if ! is_installed "stow"; then
  echo "Install stow first"
  exit 1
fi

print_subtitle "Setup configuration files"

stow_config git
stow_config zsh
stow_config nvim
stow_config tmux
stow_config opencode
