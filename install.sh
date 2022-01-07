#!/usr/bin/env bash

# Script to install dotfiles and environment on system.
# Inspired from: https://github.com/atomantic/dotfiles
# Depending if you're on a personal or remote machine, this scirpt would install
# A full or lite version

# always run from the script dir
cd "${0%/*}"

# register TERM signal to exit
trap "exit 1" TERM
export TOP_PID=$$

# Source library
source ./lib/echos.sh
source ./lib/requires.sh
source ./lib/installs.sh
source ./lib/copies.sh
source ./lib/core.sh

bot "Hi! I'm going to install tools and tweak your system settings. Here I go..."

if [[ $SSH_TTY ]]; then
  info "Seems that you're seting up a remote machine!"
  bot "First I would need your password to run sudo commands"
  sudo -v
  distro=`cat /etc/*-release | grep '^ID=' | cut -d = -f2 | sed 's/"//g'`
  if [[ $distro == 'centos' ]]; then
    get_software_centos
  else [[ $distro == 'debian' ]]
    get_software_ubuntu
  fi
  copy_dotfiles
  install_plugins
else
  info "Seems that you're seting up your main mac machine!"
  go_passwordless
  update_hosts
  install_brew
  install_brew_packages
  install_brew_casks
  link_dotfiles
  install_plugins
fi

ok "Done setting up"
