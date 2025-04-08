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
ln -sf "$working_dir/dotfiles/ohmyposh-theme.toml" ~/.config/ohmyposh-theme.toml
ln -sf "$working_dir/shell/zshrc" ~/.zshrc

print_subtask "Link tmux files"
ln -sf "$working_dir/dotfiles/tmux.conf" ~/.tmux.conf


# ------------------------------------------------------------------------------
# SETUP NVIM
# ------------------------------------------------------------------------------
print_task "Setup Nvim"

print_subtask "Cleanup any existing Nvim state"
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

print_subtask "Download NvChad"
git clone https://github.com/NvChad/starter ~/.config/nvim --depth 1

print_subtask "Link nvim files"
ln -sf "$working_dir/dotfiles/nvim" ~/.config/nvim/lua/custom