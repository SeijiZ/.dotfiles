#!/bin/bash

for f in .??*
do
   if [ "$f" = ".git" ];then
       echo ".git ignored"
       continue
   fi

   if [ "$f" = ".DS_STORE" ];then
       echo ".DS_STORE ignored"
       continue
   fi
   ln -s $HOME/.dotfiles/$f $HOME/$f

done

