#!/bin/bash

set -e

# ------------------------------------------------------------------------------
# PRETTY PRINTING
# ------------------------------------------------------------------------------

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

print_line () {
  printf "${1}"
  tput cud1
  tput sc
}

print_bold () {
  print_line "${BOLD}${1}${NORMAL}"
}

print_update () {
  tput rc
  tput cd # clear to end of screen
  print_line "${1}"
}

print_task () {
  print_update "  ${1}..."
}

print_subtask () {
  print_update "    ${1}"
}

print_error () {
  tput setaf 1
  print_bold "\n${1}"
  tput setaf 7
}

