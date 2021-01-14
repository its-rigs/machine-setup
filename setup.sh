#!/bin/bash

set -e

printf "Starting initial laptop setup:"
cd ~


# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

printnt () {
    printf "\n\n$1"
}


# ------------------------------------------------------------------------------
# SSH
# ------------------------------------------------------------------------------

SSH_FOLDER=".ssh"
SSH_CONFIG="$SSH_FOLDER/config"
SSH_KEY="$SSH_FOLDER/id_personal"

if [ ! -d "$SSH_FOLDER" ]; then
    printnt "$SSH_FOLDER doesnt exist, creating... "
    mkdir $SSH_FOLDER
fi

if [ ! -f "$SSH_CONFIG" ]; then
    printnt "Creating config file with required configuration... "
    touch $SSH_CONFIG
    printf "Host *\n\tUseKeychain yes\n\tAddKeysToAgent yes\n\tIdentityFile ~/$SSH_KEY\n" >> $SSH_CONFIG
fi

if [ ! -f $SSH_KEY ]; then
    printnt "Create SSH key... \n\n"
    ssh-keygen -q -t ed25519 -f "$SSH_KEY"
    
    printnt "Adding SSH key to agent... "
    eval "$(ssh-agent -s)"
    ssh-add -K $SSH_KEY
    
    printnt "Copying public key to clipboard... "
    pbcopy < "$SSH_KEY.pub"
fi


# ------------------------------------------------------------------------------
# Create folder structure
# ------------------------------------------------------------------------------

printnt "Creating folder structure"
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

printnt "Downloading configuration files"

read -p "Have you added SSH key to github? y/n: " can_download

if [ $can_download = "y" ]; then
    printnt "Cloning projects from github"
    cd ~/$PERSONAL_CODE

    if [ ! -d "dots" ]; then
        git clone git@github.com:its-rigs/dots.git
    fi

    if [ ! -d "machine-setup" ]; then
        git clone git@github.com:its-rigs/machine-setup.git
    fi

    cd dots

    printnt "Creating symbolic links"
    dotsdir=$(pwd)
    ln -sf "$dotsdir/gitconfig" ~/.gitconfig
    ln -sf "$dotsdir/gitignore" ~/.gitignore
    ln -sf "$dotsdir/zsh/zsh" ~/.zsh
    ln -sf "$dotsdir/zsh/zshrc" ~/.zshrc
else
    printnt "Please add SSH key to github and re-run script\n"
    exit 1
fi


# ------------------------------------------------------------------------------
# Install Homebrew
# ------------------------------------------------------------------------------

if [ ! -d /usr/local/Homebrew ]; then
    printnt "Installing Homebrew\n"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# ------------------------------------------------------------------------------
# Install applications
# ------------------------------------------------------------------------------
cd ~/$PERSONAL_CODE/machine-setup

brew bundle install --file=brewfile.standard --no-lock

read -p "Have you signed into the App Store? y/n: " can_mas

if [ $can_mas = "y" ]; then
    brew bundle install --file=brewfile.mas --no-lock
else
    printnt "Please sign in to the App Store and re-run script\n"
    exit 1
fi


TODO:
# zsh setup
# make ui pretty


printnt "Setup finished!\n"
