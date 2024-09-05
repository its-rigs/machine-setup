#!/bin/bash

set -e

source scripts/print.sh

print_bold "Setup applications"


# ------------------------------------------------------------------------------
# Install Homebrew
# ------------------------------------------------------------------------------
print_task "Checking Homebrew installed"
if [ $(command -v brew) == "" ]; then
  print_subtask "Installing Homebrew"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# ------------------------------------------------------------------------------
# Install applications
# ------------------------------------------------------------------------------
print_task "Installing apps via Homebrew"
brew bundle install --file=brewfile.standard --no-lock

print_task "Installing Mac apps via Homebrew"
brew bundle install --file=brewfile.mas --no-lock

print_line

