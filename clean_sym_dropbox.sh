#!/bin/bash

CURDIR=`pwd`

cd

su -c "yum install git zsh -y"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -s $CURDIR/.zshrc .
ln -s $CURDIR/.oh-my-zsh .
chsh -s /bin/zsh

ln -s $CURDIR/.gitconfig .

ln -s $CURDIR/.gnome-rdp.db .

ln -s $CURDIR/.hgrc .

ln -s $CURDIR/.scrobbler-helper.conf .

ln -s $CURDIR/.sqliterc .

ln -s $CURDIR/.vim .

ln -s $CURDIR/.emacs.d

ln -s $CURDIR/.vimrc .

cd ~/.config

ln -s $CURDIR/openbox .

ln -s $CURDIR/pianobar .

ln -s $CURDIR/terminator .
