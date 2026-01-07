#!/bin/bash

set -e

mac () {
  print_subtitle "Mac Settings"

  # TODO: accept flag for this
  # xcode-select --install

  print_task "Setting key preferences"
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
  print_task_done

  print_task "Checking Homebrew installed"
  if [ $(command -v brew) == "" ]; then
    print_subtask "Installing Homebrew"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  print_task_done

  print_task "Updating Homebrew"
  brew update --quiet
  print_task_done
}

arch_linux () {
  print_bold "Linux Settings"

  print_task "Updating package lists"
  sudo pacman -Syu --noconfirm
}

if isMacOS; then
  mac
elif isLinux; then
  arch_linux
else
  print_error "Unknown operating system: $OS_NAME"
  exit 1
fi