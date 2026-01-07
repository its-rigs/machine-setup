#!/bin/bash

clear

set -e

export SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SETUP_DIR/scripts/utils.sh"

# ------------------------------------------------------------------------------
# Start setup
# ------------------------------------------------------------------------------
print_title "Starting setup"
print_blank_line

source "$SETUP_DIR/scripts/os_settings.sh"
source "$SETUP_DIR/scripts/applications.sh"
source "$SETUP_DIR/scripts/dots.sh"
source "$SETUP_DIR/scripts/ssh.sh"

# ------------------------------------------------------------------------------
# Finished setup
# ------------------------------------------------------------------------------
print_finished

