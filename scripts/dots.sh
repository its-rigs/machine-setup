#!/bin/bash

set -e

source scripts/print.sh
DOTS_DIR=$1

# ------------------------------------------------------------------------------
# DOWNLOAD AND SETUP CONFIGS
# ------------------------------------------------------------------------------

print_task "Downloading configuration files"

print_subtask "Link git files"
ln -sf "$DOTS_DIR/gitconfig" ~/.gitconfig
ln -sf "$DOTS_DIR/gitignore" ~/.gitignore

#   cd dots

#   dotsdir=$(pwd)

#   ln -sf "$dotsdir/zsh/zsh" ~/.zsh
#   ln -sf "$dotsdir/zsh/zshrc" ~/.zshrc
#   ln -sf "$dotsdir/vim/vimrc" ~/.vimrc
#   ln -sf "$dotsdir/vim/vim" ~/.vim
# else
#   print_error "Please add SSH key to github and re-run script\n"
#   exit 1
# fi

