#!/bin/bash

set -eu

# ------------------------------------------------------------------------------
# PRETTY PRINTING
# ------------------------------------------------------------------------------

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

print () {
  printf "${BOLD}${1}${NORMAL}"
  tput cud1
  tput sc
}


# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

PROJECTS_FOLDER=~/Projects
MACHINE_SETUP="$PROJECTS_FOLDER/machine-setup"

print "Creating projects folder & downloading setup repo"
if [ ! -d ~/Projects ]; then
  mkdir "$PROJECTS_FOLDER"
fi

cd "$PROJECTS_FOLDER"

if [ ! -d "$MACHINE_SETUP" ]; then
  git clone https://github.com/its-rigs/machine-setup.git -q
else
  cd "$MACHINE_SETUP"
  git pull
fi

cd "$MACHINE_SETUP"
source "setup.sh"
