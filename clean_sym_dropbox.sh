#!/bin/bash

CURDIR=`pwd`

cd

ln -s $CURDIR/.bash_profile .

ln -s $CURDIR/.bashrc .

ln -s $CURDIR/.gitconfig .

ln -s $CURDIR/.gnome-rdp.db .

ln -s $CURDIR/.hgrc .

ln -s $CURDIR/.scrobbler-helper.conf .

ln -s $CURDIR/.sqliterc .

rm .vim
ln -s $CURDIR/.vim .

ln -s $CURDIR/.emacs.d

ln -s $CURDIR/.vimrc .

cd ~/.config

ln -s $CURDIR/openbox .

ln -s $CURDIR/pianobar .

ln -s $CURDIR/terminator .
#rm tint2
#ln -s $CURDIR/tint2 .
