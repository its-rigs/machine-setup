#!/bin/bash

set -e

source scripts/print.sh


# ------------------------------------------------------------------------------
# SSH
# ------------------------------------------------------------------------------

SSH_FOLDER=".ssh"
SSH_CONFIG="$SSH_FOLDER/config"
SSH_KEY="$SSH_FOLDER/id_personal"

cd ~

print_task "Checking SSH configured"

print_subtask "Creating $SSH_FOLDER"
if [ ! -d "$SSH_FOLDER" ]; then
  mkdir $SSH_FOLDER
fi

print_subtask "Creating SSH config file"
if [ ! -f "$SSH_CONFIG" ]; then
  touch $SSH_CONFIG
  printf "Host *\n\tUseKeychain yes\n\tAddKeysToAgent yes\n\tIdentityFile ~/$SSH_KEY\n" >> $SSH_CONFIG
fi

print_subtask "Creating SSH key"
if [ ! -f $SSH_KEY ]; then
  ssh-keygen -q -t ed25519 -f "$SSH_KEY"

  print_subtask "Adding SSH key to agent"
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain $SSH_KEY
fi

