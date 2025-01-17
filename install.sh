#!/usr/bin/env bash

# always run from the script dir
cd "${0%/*}" || return

# Source library
source ./lib/installs.sh
source ./lib/core.sh

if [[ $DEVPOD ]]; then
	# For Devpod
	sudo apt-get update && sudo apt-get -y upgrade
	install_pack 'sudo apt-get install -y' ./packages/devpod.pack
	link_dotfiles
	create_zshenv
	install_zsh_plugin
elif [[ $SSH_TTY ]]; then
	# For Debian/Ubuntu linux
	sudo -v
	sudo apt update && sudo apt -y upgrade
	install_pack 'sudo apt install -y' ./packages/apt.pack
	install_packs 'sudo snap install' ./packages/snap.pack
	install_pack 'sudo npm i -g' ./packages/npm.pack
	install_pack 'python3 -m pip install --break-system-packages' ./packages/pip.pack
	sudo snap alias tmux-non-dead.tmux tmux # set alias to tmux snap
	link_dotfiles
	source_bashrc
	install_lazygit_source "$HOME"/Software/lazygit
	install_delta_ubuntu "$HOME"/Software/delta
	install_astronvim
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
	create_zshenv
	install_astronvim
	install_tmux_plugin
	install_zsh_plugin
fi
