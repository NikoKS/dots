# Compilation of script to install software from source

local_bin=$HOME/.local/bin
config_dir=$HOME/.config
tmux_plugins_dir=$config_dir/tmux/plugins
zsh_dir=$config_dir/zsh

# install latest nvim appimage
# argument: nvim install directory
function install_nvim_appimage() {
	mkdir -p "$1"
	pushd "$1" || return
	lastversion --asset neovim/neovim --filter appimage$ -d nvim.AppImage
	chmod u+x nvim.AppImage
	./nvim.AppImage --appimage-extract 1>/dev/null
	mkdir -p "$local_bin"
	ln -fs "$(pwd)"/squashfs-root/AppRun "$local_bin"/nvim
	popd || return
}

# install latest tmux appimage
# argument: tmux install directory
function install_tmux_appimage() {
	mkdir -p "$1"
	pushd "$1" || return
	lastversion tmux --pre --having-asset "~\.AppImage" --assets --filter AppImage -d tmux.AppImage
	chmod u+x tmux.AppImage
	./tmux.AppImage --appimage-extract 1>/dev/null
	mkdir -p "$local_bin"
	ln -fs "$(pwd)"/squashfs-root/AppRun "$local_bin"/tmux
	popd || return
}

# install zsh latest from source (NOT WORKING: cannot compile from github source)
# argument: zsh install directory
function install_zsh_source() {
	mkdir -p "$1"
	info "installing zsh in $1"
	pushd "$1" || return
	require_yum ncurses-devel
	lastversion --assets zsh-users/zsh --filter tar.gz -d zsh.tar.gz
	mkdir zsh-latest
	tar -xf zsh.tar.gz -C zsh-latest --strip-components 1
	cd zsh-latest || return
	./configure >/dev/null
	sudo make >/dev/null
	sudo make install >/dev/null
	sudo make clean >/dev/null
	popd || return
	ok
}

# install tmux plugin using tpm
function install_tmux_plugin() {
	mkdir -p plugins_dir
	git clone --depth 1 https://github.com/tmux-plugins/tpm.git "$tmux_plugins_dir"/tpm
	tmux new-session -d "sleep 5" && sleep 1
	tmux source "$config_dir"/tmux/tmux.conf
	"$tmux_plugins_dir"/tpm/bin/install_plugins
}

# install zsh plugin
function install_zsh_plugin() {
	git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_dir"/zsh-syntax-highlighting
	git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git "$zsh_dir"/zsh-history-substring-search
	git clone --depth 1 https://github.com/softmoth/zsh-vim-mode.git "$zsh_dir"/zsh-vim-mode
	git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$zsh_dir"/powerlevel10k
}

function install_astronvim() {
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
}

# install homebrew for macos
function install_brew() {
	# Install Homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function install_pack() {
	# use $1 command to install packages in $2
	eval $1 $(awk '!/^#/{ printf "%s ", $0 } END { print "" }' $2)
}

# Like install_pack, but do it recursively
function install_packs() {
	# use $1 command to install packages in $2
	eval $(awk -v var="$1" '!/^(#|$)/ { if (line) printf " && "; printf "%s %s",var, $0; line=1 } END { if (line) print "" }' $2)
}
