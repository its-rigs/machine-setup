#!/bin/bash

set -e

# ------------------------------------------------------------------------------
# OS DETECTION
# ------------------------------------------------------------------------------

OS_NAME=$(uname)

isMacOS() {
    [[ "$OS_NAME" == "Darwin" ]]
}

isLinux() {
    [[ "$OS_NAME" == "Linux" ]]
}

# TODO:
# if isMacOS; then
#     echo "This is macOS."
# elif isLinux; then
#     echo "This is Linux."
# else
#     echo "Unknown operating system. $OS_NAME"
# fi

# ------------------------------------------------------------------------------
# PRETTY PRINTING
# ------------------------------------------------------------------------------

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

print_line () {
  printf "${1}"
  tput cud1 # move down a line
}

print_bold () {
  printf "${BOLD}${1}${NORMAL}"
}

print_title () {
  tput setaf 6 # set text color to cyan
  print_bold "${1}"
  tput setaf 7 # reset text color to default
  tput cud1 # move down a line
}

print_subtitle () {
  print_bold "${1}"
  tput cud1 # move down a line
}

print_task () {
  printf "  ${1}... "
  tput sc # save cursor position
  tput cud1 # move down a line
}

print_task_done () {
  tput rc # restore cursor position
  tput cd # clear to end of screen
  print_line "✅"
}

print_subtask () {
  tput cd # clear to end of screen
  print_line "    ${1}"
}

print_error () {
  tput setaf 1
  print_bold "\n${1}"
  tput setaf 7
}

print_blank_line () {
  tput ind
}

print_finished () {
  print_blank_line
  tput setaf 2
  print_bold "Setup finished!"
  tput setaf 7
}


# ------------------------------------------------------------------------------
# INSTALL UTILITIES
# ------------------------------------------------------------------------------

is_installed() {
  command -v "$1" &> /dev/null;
}

install_packages_mac() {
  local packages=("$@")

  print_subtask "Installing: ${packages[*]}"
  brew install --quiet "${packages[@]}"
}

install_packages_mac_casks() {
  local packages=("$@")

  print_subtask "Installing: ${packages[*]}"
  brew install --quiet --cask "${packages[@]}"
}