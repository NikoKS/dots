# Do dotfiles installation for remote machine

source ./lib/echos.sh
source ./lib/installs.sh
source ./lib/requires.sh

bot "Seems that you're on a remote machine. Doing environment setup for remote machine"

# Latest ubuntu LTS version
lts="20.04"
`lsb_release -a 2> /dev/null | grep $lts > /dev/null` 2>&1
if [[ $? = 0 ]]; then
  latest=0
else
  latest=1
fi

bot "First, let's install the essential software"
read -r -p "Check and install tmux nvim zsh and kitty? [y|N]" response
if [[ $response =~ (yes|y|Y) ]];then
  if [[ $latest = 1 ]]; then
    bot "Nice your Ubuntu machine already running latest LTS version"
    info "intalling zsh, tmux, and neovim from apt"
    require_apt tmux
    require_apt neovim
    require_apt zsh
    require_apt kitty
  else
    bot "Your Ubuntu is outdated, needs to install packages from source"
    info "installing zsh, tmux, and neovim from source"
    install_dir=$HOME/Software
    mkdir -p $install_dir
    require_pip lastversion
    install_tmux $install_dir/tmux
    install_nvim $install_dir/nvim
    install_kitty $install_dir/kitty
    require_apt zsh
  fi
else
  ok "skipped installing software"
fi

# Copy dotfiles
bot "Copying dotfiles to your remote system"
read -r -p "Continue ? [y|N] " response
if [[ $response =~ (yes|y|Y) ]];then
  running "copying bashrc to ~/.extrabashrc"
  cp dotfiles-remote/bashrc ~/.extrabashrc
  ok
  running "copying zshrc to ~/.zshrc"
  cp dotfiles-remote/zshrc ~/.zshrc
  ok
  running "copying neighboring_window.py to ~/.config/kitty/"
  mkdir -p ~/.config/kitty
  cp dotfiles-remtote/neighboring_window.py ~/.config/kitty/
  ok
  running "copying vimrc to ~/.config/nvim/init.vim"
  mkdir -p ~/.config/nvim
  cp dotfiles-remtote/vimrc ~/.config/nvim/init.vim
  ok
  running "copying tmux.conf to ~/.config/tmux/"
  mkdir -p ~/.config/tmux
  cp dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
  ok

  # sourcing extrabashrc
  bot "Check if your bashrc already source extrabashrc"
  grep -q "source.*extrabashrc" $HOME/.bashrc
  if [[ $? != 0 ]]; then
    info "not sourced yet, adding source to .bashrc"
    cat "source $HOME/.extrabashrc" >> $HOME/.bashrc
  else
    ok "Already sourced"
  fi
else
  ok "skipped copying dotfiles"
fi





