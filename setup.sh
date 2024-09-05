#!/bin/bash

set -e

source scripts/print.sh


# ------------------------------------------------------------------------------
# Start setup
# ------------------------------------------------------------------------------
tput setaf 6
print_bold "Starting setup:"
tput setaf 7

source scripts/settings.sh
source scripts/applications.sh
source scripts/folders.sh
source scripts/ssh.sh


# ------------------------------------------------------------------------------
# Finished setup
# ------------------------------------------------------------------------------
tput rc
tput cd # clear to end of screen

tput setaf 6
print_line
print_bold "Setup finished!"
tput setaf 7
