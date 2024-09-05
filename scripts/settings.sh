#!/bin/bash

set -e

source scripts/print.sh

print_bold "Mac Settings"

print_task "Setting key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

print_line
