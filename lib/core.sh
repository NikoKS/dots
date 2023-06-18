# Contains the core functionality of Dots
config_dir=$HOME/.config

function go_passwordless() {
	echo "Easier to do it manually"
	echo "see: https://jefftriplett.com/2022/enable-sudo-without-a-password-on-macos/"
}

function link_dotfiles() {
	mkdir -p "$config_dir"/zsh
	mkdir -p "$config_dir"/tmux
	mkdir -p "$config_dir"/lazygit
	mkdir -p "$config_dir"/astronvim

	# stow
	stow --dotfiles -vDt "$config_dir" dotfiles
	stow --dotfiles -vt "$config_dir" dotfiles
}

function source_bashrc() {
	if [ ! -f "$HOME"/.bashrc ] || ! grep -q "source $config_dir/bash/bashrc" "$HOME"/.bashrc; then
		touch "$HOME"/.bashrc
		echo "source $config_dir/bash/bashrc" >>"$HOME"/.bashrc
	fi
}
