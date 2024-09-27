#!/bin/bash

set -e

source scripts/print.sh


# ------------------------------------------------------------------------------
# Create folder structure
# ------------------------------------------------------------------------------

print_task "Creating folders"
PERSONAL="personal"
WORK="work"
CODE="code"

if [ ! -d ~/$PERSONAL ]; then
  mkdir ~/$PERSONAL
fi

if [ ! -d ~/$WORK ]; then
  mkdir ~/$WORK
fi

if [ ! -d ~/$CODE ]; then
  mkdir ~/$CODE
fi

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
