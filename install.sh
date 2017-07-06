#!/bin/bash

for f in .??*
do
    [[ "$f" == ".git"]] && continue
    [[ "$f" == ".DS_STORE"]] && continue
    echo $HOME/.dotfiles/$f $HOME/$f
    ln -s $HOME/.dotfiles/$f $HOME/$f

    #ln -s  $f $HOME/$f
done
