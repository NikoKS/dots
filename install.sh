#!/usr/bin/env bash

# Script to install dotfiles and environment on system.
# Inspired from: https://github.com/atomantic/dotfiles
# Depending if you're on a personal or remote machine, this scirpt would install
# A full or lite version

# Source library
source ./lib/echos.sh
source ./lib/requires.sh
source ./lib/installs.sh
source ./lib/copies.sh
source ./lib/core.sh

if [[ $SSH_TTY ]]; then
  remote=1
else
  remote=0
fi

if [[ remote -eq 1 ]]; then
  firstname="stranger"
else
  fullname=`osascript -e "long user name of (system info)"`
  if [[ -n "$fullname" ]];then
    lastname=$(echo $fullname | awk '{print $2}');
    firstname=$(echo $fullname | awk '{print $1}');
  else
    lastname="danger"
    firstname="stranger"
  fi
fi

bot "Hi ${firstname}! I'm going to install tools and tweak your system settings. Here I go..."

if [[ remote -eq 0 ]]; then
  info "Seems that you're seting up your local machine!"
  go_passwordless
  update_hosts
  install_brew
  install_brew_packages
  install_brew_casks
  link_dotfiles
  install_plugins
else
  info "Seems that you're seting up your remote machine!"
  bot "First I would need your password to run sudo commands"
  sudo -v
  get_software_ubuntu
  copy_dotfiles
  install_plugins
fi

ok "Done setting up"
