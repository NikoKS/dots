# Compilation of script to install software from source

function version_greater_equal() {
  printf '%s\n' "$2" "$1" | sort -V -C
}

function clone_or_pull() {
  if [[ -d $1 ]]; then
    info "$1 exist, updating"
    pushd $1 > /dev/null
    git pull --ff-only
    popd > /dev/null
  else
    info "cloning $2 to $1"
    git clone --depth=1 $2 $1
  fi
}

# Install poetry

function install_poetry() {
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
}

# install lunarvim rolling branch
function install_lvim_rolling() {
  require_package nodejs
  require_package python3
  require_package cargo
  require_pip3 pynvim
  NPM_PACKAGES="$HOME/.npm-packages"
  mkdir -p "$NPM_PACKAGES"
  echo "prefix = $NPM_PACKAGES" >> ~/.npmrc
  LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
}

function install_lvim_stable() {
  require_package nodejs
  require_package python3
  require_package cargo
  require_pip3 pynvim
  NPM_PACKAGES="$HOME/.npm-packages"
  mkdir -p "$NPM_PACKAGES"
  echo "prefix = $NPM_PACKAGES" >> ~/.npmrc
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

# install latest nvim appimage
# argument: nvim install directory
function install_nvim_appimage() {
  mkdir -p $1
  info "installing nvim in $1"
  pushd $1
  lastversion --asset neovim/neovim --filter appimage$ -d nvim.AppImage
  chmod u+x nvim.AppImage
  ./nvim.AppImage --appimage-extract 1> /dev/null
  info "linking nvim binary to local bin"
  local_bin=$HOME/.local/bin
  mkdir -p $local_bin
  ln -fs `pwd`/squashfs-root/AppRun $local_bin/nvim
  popd
  ok
}

# install latest tmux appimage
# argument: tmux install directory
function install_tmux_appimage() {
  mkdir -p $1
  info "installing tmux in $1"
  pushd $1
  lastversion tmux --pre --having-asset "~\.AppImage" --assets --filter AppImage -d tmux.AppImage
  chmod u+x tmux.AppImage
  ./tmux.AppImage --appimage-extract 1> /dev/null
  info "linking tmux binary to local bin"
  local_bin=$HOME/.local/bin
  mkdir -p $local_bin
  ln -fs `pwd`/squashfs-root/AppRun $local_bin/tmux
  popd
  ok
}

# install tmux plugin using tpm
function install_tmux_plugin() {
  action "Installing tmux plugins"
  TP=$HOME/.config/tmux/plugins
  TPM=$TP/tpm
  clone_or_pull $TPM https://github.com/tmux-plugins/tpm.git
  tmux new-session -d "sleep 5" && sleep 1
  tmux source $HOME/.config/tmux/tmux.conf
  $TPM/bin/install_plugins
  print_success "finished installing tmux plugins"
}

# install zsh plugin
function install_zsh_plugin() {
  action "Installing zsh plugins"
  ZSH=$HOME/.config/zsh
  mkdir -p $HOME/.cache/zsh
  clone_or_pull $ZSH/zsh-syntax-highlighting \
    https://github.com/zsh-users/zsh-syntax-highlighting.git
  clone_or_pull $ZSH/zsh-history-substring-search \
    https://github.com/zsh-users/zsh-history-substring-search.git
  clone_or_pull $ZSH/powerlevel10k \
    https://github.com/romkatv/powerlevel10k.git 
  require_package autojump
  print_success "finished installing zsh plugins"
}

# install homebrew for macos
function install_brew() {
  # Install Homebrew
  bot "Time to start brewing"
  running "checking homebrew..."
  brew_bin=`hash brew` 2>&1 > /dev/null
  
  # Check if brew already installed
  if [[ $? != 0 ]]; then
    action "installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
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
}
