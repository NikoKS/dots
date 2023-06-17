#!/usr/bin/env bash

# always run from the script dir
cd "${0%/*}" || return

# Source library
source ./lib/installs.sh
source ./lib/core.sh

if [[ $SSH_TTY ]]; then
	# For linux
	software=$HOME/Software
	sudo -v
	sudo apt update && sudo apt -y upgrade
	install_pack 'apt install -y' ./packages/apt.pack
	install_pack 'pip install' ./packages/pip-remote.pack
	install_pack 'npm i -g' ./packages/npm.pack
	install_pack 'cargo install' ./packages/cargo.pack
	install_nvim_appimage "$software"
	install_tmux_appimage "$software"
	link_dotfiles
	install_tmux_plugin
	install_zsh_plugin
else
	# For Macos
	go_passwordless
	# update_hosts (to be implemented)
	install_brew
	install_pack 'brew install' ./packages/brew.pack
	install_pack 'brew install --cask' ./packages/cask.pack
	install_pack 'npm i -g' ./packages/npm.pack
	link_dotfiles
fi
