#!/bin/bash

if hash apt-get 2>/dev/null; then
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y git vim build-essential
else
    if hash brew 2>/dev/null; then
        echo "Homebrew already installed"
    else
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi
    brew install git
fi

git clone https://github.com/aequasi/dotfiles.git /tmp/dotfiles
cd /tmp/dotfiles

bold=`tput bold`
normal=`tput sgr0`

echo "${bold}Setting up Dot Files for this machine!${normal}\n"

# Update PHP Syntax for this machine
if hash php 2>/dev/null; then
    php vim-php-syntax/update_syntax.php
    echo "PHP Syntax updated based on installed packages..."
fi

# Remove any existing .vim folder
if [ -e ~/.vim ]; then
    sudo rm -r ~/.vim
fi

# Copy the required files to the home directory
rm -r ~/.bash_git ~/.bash_profile ~/.bashrc ~/.gitconfig ~/.gitignore_global ~/.vimrc ~/.vim ~/git-completion.bash
cp -r .bash_git .bash_profile .bashrc .gitconfig .gitignore_global .vimrc .vim git-completion.bash ~/
echo "Dot Files copied into your home directory..."
echo "Done.\n\n"

# Setup .gitconfig
echo "${bold}Let's configure your Git configuration!${normal}\n"
echo "What is your full name? (ex: John Doe)"
read name
echo "And what is your email address? (ex: test@gmail.com)"
read email

echo "[user]\n\temail = $email\n\tname = $name\n" >> ~/.gitconfig

echo "\n** Finished!"

cd -
rm -r /tmp/dotfiles
source ~/.bashrc
