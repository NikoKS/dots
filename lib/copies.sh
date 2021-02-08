# Compilation of functions to copy dotfiles

function extract() {
  sed -En '/'$1'/, /" ?}}}/p' $2
}

function exclude() {
  sed -E '/'$1'/, /" ?}}}/d' $2
}

function copy_vimrc() {
  vimrc=$1
  init='dotfiles/nvim/init.vim'
  dotvim='dotfiles/nvim/dotvim' 
  exclude 'Heavier Plugins' $dotvim/minpac.vim > $vimrc
  extract 'Basic Config' $init >> $vimrc
  extract 'Core Plugin' $init >> $vimrc
  extract 'Additional Settings' $init >> $vimrc
  extract 'Core Functions' $dotvim/functions.vim >> $vimrc
  extract 'Core Remaps' $dotvim/remaps.vim >> $vimrc
}
