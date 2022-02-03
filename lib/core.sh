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
  bot "OK, let's install the essential software for ubuntu"
  read -r -p "Check and install tmux, nvim, and zsh? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    install_dir=$HOME/Software
    mkdir -p $install_dir
    require_pip lastversion
    info 'removing apt instalation of tmux'
    sudo apt purge tmux 2> /dev/null
    install_tmux $install_dir/tmux
    info 'installing fzf'
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    info 'removing apt installation of neovim'
    sudo apt purge neovim 2> /dev/null
    install_nvim $install_dir/nvim
    require_apt zsh
  else
    ok "skipped installing software"
  fi
}

function get_software_centos() {
  bot "OK, let's install the software for centos"
  read -r -p "Check and install tmux, nvim, and zsh? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    install_dir=$HOME/Software
    mkdir -p $install_dir
    require_pip lastversion
    # Tmux
    info 'removing yum installation of tmux'
    sudo yum erase -y tmux 2> /dev/null
    install_tmux_appimage $install_dir/tmux
    # fzf
    info 'installing fzf'
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    # gcc 7
    info 'installing gcc 7'
    require_yum centos-release-scl
    require_yum devtoolset-7
    # nvim
    info 'removing yum installation of neovim'
    sudo yum erase -y neovim 2> /dev/null
    install_nvim_appimage $install_dir/nvim
    install_lvim_rolling
    # zsh
    info 'installing zsh 5.8 from source'
    install_tmux_source $install_dir/zsh

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
    if [[ $distro == 'centos' ]]; then
      echo 'export PATH="/opt/rh/devtoolset-7/root/usr/bin/:$PATH"' >> ~/.zshrc
    fi
    ok

    running "generating vimrc in ~/.config/lvim/config.lua"
    lvim_dir=$HOME/.config/lvim
    mkdir -p $lvim_dir
    cp dotfiles/lvim/config.lua $lvim_dir/config.lua
    mkdir -p $lvim_dir/lua
    cp -r dotfiles/lvim/lua/* $lvim_dir/lua/
    cp -r dotfiles/lvim/after $lvim_dir
    ok

    running "copying tmux.conf to ~/.config/tmux/"
    mkdir -p ~/.config/tmux
    touch ~/.tmux.conf
    cp dotfiles/tmux/remote_tmux.conf ~/.config/tmux/tmux.conf
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
  bot "We can now install Plugins for tmux, lvim, and zsh"
  read -r -p "Continue plugin installation? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    install_tmux_plugin
    install_zsh_plugin
    info "Install lvim plugin directly inside lvim"
  else
    ok "skipped installing pugins"
  fi
}
