#!/usr/bin/env bash

git clone --bare git@github.com:jujodeve/.dotfiles.git $HOME/.dotfiles

function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dotfiles checkout

if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Removing pre-existing dot files.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} rm {}
fi;

dotfiles checkout

dotfiles config status.showUntrackedFiles no
