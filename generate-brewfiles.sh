#!/bin/bash

set -e

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
  print_line "\t${1}"
}

STANDARD_BREW="brewfile.standard"
MAS_BREW="brewfile.mas"

tput clear
print_bold "Generating new brew files"

print_update "Removing old files"
rm $STANDARD_BREW $MAS_BREW

print_update "Creating new files"
touch $STANDARD_BREW $MAS_BREW

print_update "Generating Brewfile"
brew bundle dump -f

print_update "Splitting Brewfile"
while read line; do
  split=$(echo $line | cut -d " " -f 1)

  if [ $split = "mas" ];
  then
    echo $line >> $MAS_BREW
  else
    echo $line >> $STANDARD_BREW
  fi
done <Brewfile

print_update "Deleting Brewfile"
rm Brewfile

print_bold "Finished generating brew files\n"
