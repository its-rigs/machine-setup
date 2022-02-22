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

# ------------------------------------------------------------------------------
# START HERE
# ------------------------------------------------------------------------------

cd ~
tput clear

tput setaf 6
print_bold "Starting initial laptop setup:"
tput setaf 7

# ------------------------------------------------------------------------------
# SSH
# ------------------------------------------------------------------------------

SSH_FOLDER=".ssh"
SSH_CONFIG="$SSH_FOLDER/config"
SSH_KEY="$SSH_FOLDER/id_personal"

print_task "Checking SSH configured"

if [ ! -d "$SSH_FOLDER" ]; then
  print_subtask "  $SSH_FOLDER doesnt exist, creating"
  mkdir $SSH_FOLDER
fi

if [ ! -f "$SSH_CONFIG" ]; then
  print_subtask "Creating config file with required configuration"
  touch $SSH_CONFIG
  printf "Host *\n\tUseKeychain yes\n\tAddKeysToAgent yes\n\tIdentityFile ~/$SSH_KEY\n" >> $SSH_CONFIG
fi

if [ ! -f $SSH_KEY ]; then
  print_subtask "Create SSH key"
  ssh-keygen -q -t ed25519 -f "$SSH_KEY"

  print_subtask "Adding SSH key to agent"
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain $SSH_KEY

  print_subtask "Copying public key to clipboard"
  pbcopy < "$SSH_KEY.pub"
fi


# ------------------------------------------------------------------------------
# Create folder structure
# ------------------------------------------------------------------------------

print_task "Creating folder structure"
PERSONAL="personal"
WORK="work"
CODE="code"
PERSONAL_CODE="$CODE/$PERSONAL"

if [ ! -d ~/$PERSONAL ]; then
  cd ~
  mkdir $PERSONAL
fi

if [ ! -d ~/$WORK ]; then
  cd ~
  mkdir $WORK
fi

if [ ! -d ~/$CODE ]; then
  cd ~
  mkdir $CODE
fi

if [ ! -d ~/$PERSONAL_CODE ]; then
  cd ~/CODE
  mkdir $PERSONAL
fi


# ------------------------------------------------------------------------------
# DOWNLOAD AND SETUP CONFIGS
# ------------------------------------------------------------------------------

print_task "Downloading configuration files"

read -p "Have you added SSH key to github? y/n: " can_download

if [ $can_download = "y" ]; then
  print_subtask "Cloning projects from github"
  cd ~/$PERSONAL_CODE

  if [ ! -d "dots" ]; then
    git clone git@github.com:its-rigs/dots.git
  fi

  if [ ! -d "machine-setup" ]; then
    git clone git@github.com:its-rigs/machine-setup.git
  fi

  cd dots

  print_subtask "Creating symbolic links"
  dotsdir=$(pwd)
  ln -sf "$dotsdir/gitconfig" ~/.gitconfig
  ln -sf "$dotsdir/gitignore" ~/.gitignore
  ln -sf "$dotsdir/zsh/zsh" ~/.zsh
  ln -sf "$dotsdir/zsh/zshrc" ~/.zshrc
  ln -sf "$dotsdir/vim/vimrc" ~/.vimrc
else
  print_error "Please add SSH key to github and re-run script\n"
  exit 1
fi


# ------------------------------------------------------------------------------
# Install Homebrew
# ------------------------------------------------------------------------------

print_task "Checking Homebrew installed"
if [ ! -d /usr/local/Homebrew ]; then
  print_subtask "Installing Homebrew"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# ------------------------------------------------------------------------------
# Install applications
# ------------------------------------------------------------------------------
cd ~/$PERSONAL_CODE/machine-setup

print_task "Installing apps via Homebrew"
brew bundle install --file=brewfile.standard --no-lock

print_task "Installing Mac apps via Homebrew"
read -p "Have you signed into the App Store? y/n: " can_mas

if [ $can_mas = "y" ]; then
  brew bundle install --file=brewfile.mas --no-lock
else
  print_error "Please sign in to the App Store and re-run script"
  exit 1
fi


# TODO:
# zsh setup
# allow hold key 

tput rc
tput cd # clear to end of screen
tput setaf 6
print_bold "Setup finished!"
tput setaf 7
