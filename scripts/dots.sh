#!/bin/bash

set -e

working_dir=$(pwd)

source scripts/print.sh

# ------------------------------------------------------------------------------
# DOWNLOAD AND SETUP CONFIGS
# ------------------------------------------------------------------------------

print_task "Setup configuration files"

print_subtask "Link git files"
ln -sf "$working_dir/git/gitconfig" ~/.gitconfig
ln -sf "$working_dir/git/gitignore" ~/.gitignore

print_subtask "Link zsh files"
ln -sf "$working_dir/shell/zsh" ~/.zsh
ln -sf "$working_dir/shell/zshrc" ~/.zshrc