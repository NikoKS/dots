# Contains the core functionality of Dots

function go_passwordless() {
  # Do we need to ask for sudo password or is it already passwordless?
  grep -q 'NOPASSWD:     ALL' /etc/sudoers.d/$LOGNAME > /dev/null 2>&1
  if [[ $? != 0 ]]; then
    info "sudo not set as passwordless. Please enter password"
    sudo -v

    # Keep-alive: update existing sudo time stamp until the script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    bot "Do you want me to setup this machine to allow you to run sudo without a password?\nPlease read here to see what I am doing:\nhttp://wiki.summercode.com/sudo_without_a_password_in_mac_os_x \n"

    read -r -p "Make sudo passwordless? [y|N] " response

    if [[ $response =~ (yes|y|Y) ]];then
      if ! sudo grep -q "#includedir /private/etc/sudoers.d" /etc/sudoers; then
        action "Appending the following to /etc/sudoers"
        echo '#includedir /private/etc/sudoers.d' | sudo tee -a /etc/sudoers > /dev/null
      fi
      action "Adding the following to /etc/sudoers.d/$LOGNAME"
      echo -e "Defaults:$LOGNAME    !requiretty\n$LOGNAME ALL=(ALL) NOPASSWD:     ALL" | sudo tee /etc/sudoers.d/$LOGNAME
      bot "You can now run sudo commands without password!\n"
    fi
  else
    ok "found sudoers file, don't need password"
  fi
}

function update_hosts() {
  # /etc/hosts -- spyware/ad blocking
  bot "I can update your /etc/hosts file to block ad and unwanted sites"
  read -r -p "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
      action "cp /etc/hosts /etc/hosts.backup"
      sudo cp /etc/hosts /etc/hosts.backup
      ok
      action "Getting host file from https://someonewhocares.org/hosts/hosts"
      curl "https://someonewhocares.org/hosts/hosts" | sudo tee /etc/hosts > /dev/null
      ok
      bot "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
  else
      ok "skipped updating hosts file";
  fi
}

function install_brew_packages() {
  # Installs brew packages
  bot "Now we can install brew packages"
  read -r -p "install brew packages? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]]; then
    for pack in `sed "/^#.*/d" ./packages/brew.pack`;do
      require_brew $pack
    done
  else
    ok "Skipped installing brew packages"
  fi
}

function install_brew_casks() {
  # Installs brew casks
  bot "Time for installing your casks"
  read -r -p "install brew packages? This should take a while [y|N] " response
  if [[ $response =~ (y|yes|Y) ]]; then
    for pack in `sed "/^#.*/d" ./packages/cask.pack`;do
      require_cask $pack
    done
  else
    ok "Skipped installing cask packages"
  fi
}

function link_dotfiles() {
  # Link dotfiles to .config  
  bot "Time to link your dotfiles! Are you ready?"
  read -r -p "link dotfiles to your ~/.config folder? (This will move your existing config to a backup folder if they exist) [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then

    #Setting config and backup dir
    confdir=$HOME/.config
    backupdir=$confdir/backups

    # Check if stow exist
    require_brew stow

    # check zshenv
    grep "ZDOTDIR" $HOME/.zshenv > /dev/null 2>&1
    if [[ $? != 0 ]];then
      info "ZDOTDIR not found on zshenv. Adding ${COL_YELLOW}export ZDOTDIR=~/.config/zsh$COL_RESET to ~/.zshenv"
      echo "export ZDOTDIR=~/.config/zsh" > ~/.zshenv
    fi

    # Make directory for configs if not exist and backup if config exist
    action "Preparing and backing up old configs"
    for dir in dotfiles/* ; do
      d=`echo $dir | awk -F / '{print $NF}'`
      mkdir -p $confdir/$d
      for conf in $dir/* ; do
        c=`echo $conf | cut -d / -f 2-`
        conffile=$confdir/$c
        if [[ -e $conffile && ! -L $conffile ]] ; then
          mkdir -p $backupdir/$d
          info "moving $conffile to $backupdir/$d"
          mv $conffile $backupdir/$d
        fi
      done
    done

    # Delete symbolic link first
    action "unlinking"
    stow --dotfiles -vDt $confdir dotfiles

    # Stow the dotfiles to ~/.config
    action "linking dotfiles"
    stow --dotfiles -vt $confdir dotfiles
    ok "Finnished linking dotfiles"
  else
    ok "Skipped linking dotfiles"
  fi
}

function get_software_ubuntu() {
  bot "OK, let's install the essential software"
  lts="20.04"
  read -r -p "Check and install tmux nvim zsh and kitty? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    lsb_release -a 2> /dev/null | grep $lts > /dev/null
    if [[ $? != 0 ]]; then
      bot "Your Ubuntu is outdated, needs to install packages from source"
      info "installing zsh, tmux, and neovim from source"
      install_dir=$HOME/Software
      mkdir -p $install_dir
      require_pip lastversion
      install_tmux $install_dir/tmux
      install_nvim $install_dir/nvim
      install_kitty $install_dir/kitty
      require_apt zsh
    else
      bot "Nice your Ubuntu machine already running latest LTS version"
      info "intalling zsh, tmux, and neovim from apt"
      require_apt tmux
      require_apt neovim
      require_apt zsh
      require_apt kitty
    fi
  else
    ok "skipped installing software"
  fi
}

function copy_dotfiles() {
  # Copy dotfiles
  bot "Copying dotfiles to your remote system"
  read -r -p "Continue ? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    running "copying zshrc to ~/.zshrc"
    cp dotfiles/zsh/dot-zshrc ~/.zshrc
    mkdir -p ~/.config/zsh
    cp dotfiles/zsh/p10k.zsh ~/.config/zsh
    ok

    running "generating vimrc in ~/.config/nvim/init.vim"
    nvim_dir=$HOME/.config/nvim
    mkdir -p $nvim_dir
    copy_vimrc $nvim_dir/init.vim
    cp -r dotfiles/nvim/ftplugin $nvim_dir
    ok

    running "copying tmux.conf to ~/.config/tmux/"
    mkdir -p ~/.config/tmux
    touch ~/.tmux.conf
    cp dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
    ok

    running "copying bashrc to ~/.extrabashrc"
    cp dotfiles/remote/bashrc ~/.extrabashrc
    ok

    # sourcing extrabashrc
    bot "Check if your bashrc already source extrabashrc"
    grep -q "source.*extrabashrc" $HOME/.bashrc
    if [[ $? != 0 ]]; then
      info "not sourced yet, adding source to .bashrc"
      echo "source $HOME/.extrabashrc" >> $HOME/.bashrc
    else
      ok "Already sourced"
    fi
  else
    ok "skipped copying dotfiles"
  fi
}

function install_plugins() {
  # Install Plugins
  bot "We can now install Plugins for tmux, nvim, and zsh"
  read -r -p "Continue plugin installation? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then

    action "Installing tmux plugins"
    TP=$HOME/.config/tmux/plugin
    KT=$HOME/.config/kitty
    TPM=$TP/tpm
    clone_or_pull $TPM https://github.com/tmux-plugins/tpm.git
    tmux source ~/.config/tmux/tmux.conf
    $TPM/bin/install_plugins
    mkdir -p $KT
    cp $TP/kitty-vim-tmux-navigator/neighboring_window.py $KT
    cp $TP/kitty-vim-tmux-navigator/pass_keys.py $KT
    print_success "finished installing tmux plugins"

    action "Installing neovim plugins"
    apt_or_brew ctags
    MIN=$HOME/.config/nvim/pack/minpac/opt/minpac
    clone_or_pull $MIN https://github.com/k-takata/minpac.git
    nvim --headless -c 'call PackInit()' -c 'call minpac#update("", {"do": "qa"})'   
    print_success "finished installing neovim plugins"

    action "Installing zsh plugins"
    ZSH=$HOME/.config/zsh
    mkdir -p $HOME/.cache/zsh
    clone_or_pull $ZSH/zsh-syntax-highlighting \
      https://github.com/zsh-users/zsh-syntax-highlighting.git
    clone_or_pull $ZSH/zsh-history-substring-search \
      https://github.com/zsh-users/zsh-history-substring-search.git
    clone_or_pull $ZSH/powerlevel10k \
      https://github.com/romkatv/powerlevel10k.git 
    if [[ `uname -s` == 'Darwin' ]]; then
      require_brew autojump
    elif [[ `uname -s` == 'Linux' ]]; then
      require_apt autojump
    fi
    print_success "finished installing zsh plugins"

  else
    ok "skipped installing pugins"
  fi
}
