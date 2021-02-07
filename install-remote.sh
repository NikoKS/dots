# Do dotfiles installation for remote machine

source ./lib/echos.sh
source ./lib/installs.sh
source ./lib/requires.sh

bot "Seems that you're on a remote machine. Doing environment setup for remote machine"

# Latest ubuntu LTS version
lts="20.04"
lsb_release -a 2> /dev/null | grep $lts > /dev/null
if [[ $? = 1 ]]; then
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
  mkdir -p ~/.config/zsh
  cp dotfiles/zsh/p10k.zsh ~/.config/zsh
  ok
  running "copying neighboring_window.py to ~/.config/kitty/"
  mkdir -p ~/.config/kitty
  cp dotfiles-remote/neighboring_window.py ~/.config/kitty/
  ok
  running "copying vimrc to ~/.config/nvim/init.vim"
  mkdir -p ~/.config/nvim
  cp dotfiles-remote/vimrc ~/.config/nvim/init.vim
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

# Install Plugins
bot "We can now install Plugins for tmux, nvim, and zsh"
read -r -p "Continue plugin installation? [y|N] " response
if [[ $response =~ (yes|y|Y) ]];then

  action "Installing tmux plugins"
  TPM="~/.config/tmux/plugins/tpm"
  clone_or_pull $TPM https://github.com/tmux-plugins/tpm.git
  ${TPM}/bin/install_plugins

  action "Installing neovim plugins"
  MIN="~/.config/nvim/pack/minpac/opt/minpac"
  clone_or_pull $MIN https://github.com/k-takata/minpac.git
  nvim +PackUpdate +qall >/dev/null 2>&1
  
  action "Installing zsh plugins"
  ZSH="~/.config/zsh"
  clone_or_pull $ZSH/zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
  clone_or_pull $ZSH/zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search.git
  clone_or_pull $ZSH/powerlevel10k https://github.com/romkatv/powerlevel10k.git 
  if [[ `uname -s` == 'Darwin' ]]; then
    require_brew autojump
  elif [[ `uname -s` == 'Linux' ]]; then
    require_apt autojump
  fi

else
  ok "skipped installing pugins"
fi

