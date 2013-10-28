#!/bin/bash

#Install Emacs
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get update
sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg
sudo apt-get install -y xclip

#Random Stuff
sudo apt-get install -y unzip
sudo apt-get install -y rlwrap

#Python setup
wget -nd http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-1.7.0-Linux-x86_64.sh
bash Anaconda-1.7.0-Linux-x86_64.sh
rm Anaconda-1.7.0-Linux-x86_64.sh

#Clone dotfiles
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/pcp135/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

# Generate new key with no passphrase
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''

# Set names up on git
git config --global user.name "Phil Parsons"
git config --global user.email phil@parsons.uk.com

# Output rsa key to screen for copying into git
cat ~/.ssh/id_rsa.pub