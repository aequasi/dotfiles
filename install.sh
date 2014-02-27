#!/bin/sh

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    apt-get install -y vim rake zsh
    git clone https://github.com/aequasi/dotfiles.git -b zsh "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" == "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi
