# Compilation of functions to copy dotfiles

function extract() {
  if [[ `uname -s` = 'Darwin' ]]; then
    sed -En '/'"$1"'/, /" ?}}}/p' $2
  else
    sed -rn '/'"$1"'/, /" ?}}}/p' $2
  fi
}

function exclude() {
  if [[ `uname -s` = 'Darwin' ]]; then
    sed -E '/'"$1"'/, /" ?}}}/d' $2
  else
    sed -r '/'"$1"'/, /" ?}}}/d' $2
  fi
}

function copy_vimrc() {
  vimrc=$1
  init=dotfiles/nvim/init.vim
  dotvim=dotfiles/nvim/dotvim 
  exclude 'Heavier Plugins' $dotvim/minpac.vim > $vimrc
  extract 'Basic Config' $init >> $vimrc
  extract 'Core Plugin' $init >> $vimrc
  extract 'Additional Settings' $init >> $vimrc
  extract 'Core Functions' $dotvim/functions.vim >> $vimrc
  extract 'Core Remaps' $dotvim/remaps.vim >> $vimrc
}
