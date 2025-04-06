#!/bin/bash

set -e

working_dir=$(pwd)

source scripts/print.sh

# ------------------------------------------------------------------------------
# SETUP CONFIGS
# ------------------------------------------------------------------------------
print_task "Setup configuration files"

print_subtask "Link git files"
ln -sf "$working_dir/git/gitconfig" ~/.gitconfig
ln -sf "$working_dir/git/gitignore" ~/.gitignore

print_subtask "Link zsh files"
ln -sf "$working_dir/application-files/ohmyposh-theme.toml" ~/.config/ohmyposh-theme.toml
ln -sf "$working_dir/shell/zshrc" ~/.zshrc

print_subtask "Link tmux files"
ln -sf "$working_dir/application-files/tmux.conf" ~/.tmux.conf
