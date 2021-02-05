#!/usr/bin/env bash

# Script to install dotfiles on system.
# Inspired from:
# https://github.com/atomantic/dotfiles/blob/master/install.sh
# Only works for macos for now

# Source colored echo functions
source ./lib/echos.sh
source ./lib/requires.sh

fullname=`osascript -e "long user name of (system info)"`
if [[ -n "$fullname" ]];then
  lastname=$(echo $fullname | awk '{print $2}');
  firstname=$(echo $fullname | awk '{print $1}');
else
  lastname="danger"
  firstname="stranger"
fi

bot "Hi ${firstname}! I'm going to install tooling and tweak your system settings. Here I go..."

# Do we need to ask for sudo password or is it already passwordless? {{{
# ####################################################################

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

###################################################################}}}

# /etc/hosts -- spyware/ad blocking {{{
# ####################################################################

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

###################################################################}}}

# Install Homebrew and brew packages{{{
# ####################################################################

bot "Time to start brewing"
running "checking homebrew..."
brew_bin=$(which brew) 2>&1 > /dev/null

if [[ $? != 0 ]]; then
  action "installing homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  if [[ $? != 0 ]]; then
    error "unable to install homebrew, script $0 abort!"
    exit 2
  fi
  brew analytics off
else
  ok
  bot "Homebrew Found!"
  read -r -p "run brew update && upgrade? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]]; then
    action "updating homebrew..."
    brew update
    ok "homebrew updated"
    action "upgrading brew packages..."
    brew upgrade
    ok "brews upgraded"
  else
    ok "skipped brew package upgrades."
  fi
fi

###################################################################}}}

# Installing brew packages {{{
# ####################################################################
bot "Now we can install brew packages"
read -r -p "install brew packages? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
  for pack in `sed "/^#.*/d" ./packages/brew.pack`;do
    require_brew $pack
  done
else
  ok "Skipped installing brew packages"
fi
###################################################################}}}

# Linking dotfiles{{{
# ####################################################################

bot "Time to link your dotfiles! Are you ready?"
read -r -p "link dotfiles to your ~/.config folder? (This will move your existing config to a backup folder if they exist) [y|N] " response
if [[ $response =~ (yes|y|Y) ]];then

  #Setting config and backup dir
  confdir=$HOME/.config
  backupdir=$confdir/backups

  # Check if stow exist
  stow_bin=`which stow`
  if [[ $? != 0 ]]; then
    error "stow not found, please install it first. If you skip installing packages above, run it again"
    exit 2
  fi

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

###################################################################}}}


