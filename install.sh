#!/usr/bin/env bash

# Script to install dotfiles on system.
# Inspired from:
# https://github.com/atomantic/dotfiles/blob/master/install.sh
# Only works for macos for now

# Source colored echo functions
source ./echos.sh

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
######################################################################

grep -q 'NOPASSWD:     ALL' /etc/sudoers.d/$LOGNAME > /dev/null 2>&1
if [ $? -ne 0 ]; then
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
elif
  ok "found sudoers file, don't need password"
fi

###################################################################}}}

# /etc/hosts -- spyware/ad blocking {{{
######################################################################

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
    ok "skipped";
fi

###################################################################}}}

# Git Config {{{
# ###################################################################

bot "OK, now I am going to configure your gitconfig"
gitconfdir="$HOME/.config/git/"
homegitconf="$HOME/.gitconfig"

function updateconfig() {
  mkdir -p $gitconfdir
  cp -r ./config/git/* $gitconfdir
  bot "I can update your config file with your user info"

  username=`grep "name" ${gitconfig}/config | cut -d\  -f3`
  info "currently your user name is ${username}."
  read -r -p "do you want to change it? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    read -r -p "What is your new user name? " uname
  else
    uname=$username
  fi

  useremail=`grep "email" ${gitconfig}/config | cut -d\  -f3`
  info "currently your user name is ${useremail}."
  read -r -p "do you want to change it? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    read -r -p "What is your new user name? " uemail
  else
    uemail=$useremail
  fi

  sed 's/${username}/${uname}/; s/${useremail}/${uemail}' ${gitconfig}/config > tmp.txt
  mv tmp.txt ${gitconfig}/config
  bot "finnished updating config"
}

if [ -f "$homegitconf" ];then
  bot "gitconfig found at $homegitconf, do you want to replace it with the one I recommend?"
  read -r -p "Remove $homegitconf and copy ./config/git to $gitconfdir? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    rm $homegitconf
    updateconfig
  else
    ok "skipped"
  fi
elif [ -f "${gitconfdir}/config" ];then
  bot "config file found at ${gitconfdir}/config, do you want to replace it with the one I reccomend?"
  read -r -p "replace $gitconfdir with ./config/git? [y|N] " response
  if [[ $response =~ (yes|y|Y) ]];then
    updateconfig
  else
    ok "skipped"
  fi
else
  info "cannot find existing gitconfig file, copying default config to $gitconfdir"
  updateconfig
fi

###################################################################}}}

# Install Homebrew and brew packages{{{
######################################################################

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
  bot "Homebrew"
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
else
  bot "Homebrew found!"
fi

###################################################################}}}
