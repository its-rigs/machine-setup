#!/bin/sh 

BABUSHKA_FOLDER=/usr/local/babushka
USR_LOCAL_BIN=/usr/local/bin

printf "Checking babushka setup... "

if [ ! -d "$BABUSHKA_FOLDER" ]; then
  printf "\n\tCreating $BABUSHKA_FOLDER... "
  sudo mkdir -p $BABUSHKA_FOLDER
  printf "complete."
fi

if [ ! -d "$USR_LOCAL_BIN" ]; then
  printf "\n\tCreating $USR_LOCAL_BIN... "
  sudo mkdir -p $USR_LOCAL_BIN
  printf "complete."
fi

printf "\n\tSetting permissions for folders..."
sudo chown -R `whoami` $BABUSHKA_FOLDER
sudo chown -R `whoami` $USR_LOCAL_BIN
printf "complete."

if ! command -v babushka > /dev/null; then
  printf "\n\tInstalling... "
  sudo sh -c "`curl https://babushka.me/up`"
  printf "complete."
fi

printf "\nComplete!\n"

