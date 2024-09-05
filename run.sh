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

CONFIGURATION_FOLDER=~/.configuration
MACHINE_SETUP=machine-setup
DOTS=dots

print "Creating configuration folder"

if [ ! -d $CONFIGURATION_FOLDER ]; then
  mkdir $CONFIGURATION_FOLDER
fi

cd $CONFIGURATION_FOLDER

print "Downloading machine setup files"
if [ ! -d $MACHINE_SETUP ]; then
  git clone https://github.com/its-rigs/machine-setup.git
fi

print "Downloading dot files"
if [ ! -d $DOTS ]; then
  git clone https://github.com/its-rigs/dots.git
fi

cd $MACHINE_SETUP
source setup.sh
