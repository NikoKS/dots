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

# install lunarvim rolling branch
function install_lvim_rolling() {
  LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
}

function install_lvim_stable() {
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
  ./nvim.AppImage --appimage-extract
  info "linking nvim binary to local bin"
  local_bin=$HOME/.local/bin
  mkdir -p $local_bin
  ln -fs `pwd`/squashfs-root/AppRun $local_bin/tmux
  popd
  ok
}

# install lunarvim plugin
function install_lvim_plugin() {
  action "Installing neovim plugins"
  apt_or_brew ctags
  MIN=$HOME/.config/nvim/pack/minpac/opt/minpac
  clone_or_pull $MIN https://github.com/k-takata/minpac.git
  nvim --headless -c 'call PackInit()' -c 'call minpac#update("", {"do": "qa"})'   
  print_success "finished installing neovim plugins"
}

# install latest tmux appimage
# argument: tmux install directory
function install_tmux_appimage() {
  mkdir -p $1
  info "installing tmux in $1"
  pushd $1
  lastversion tmux --pre --having-asset "~\.AppImage" --assets --filter AppImage -d tmux.AppImage
  chmod u+x tmux.AppImage
  ./tmux.AppImage --appimage-extract
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
  KT=$HOME/.config/kitty
  TPM=$TP/tpm
  clone_or_pull $TPM https://github.com/tmux-plugins/tpm.git
  tmux new-session -d "sleep 5" && sleep 1
  tmux source $HOME/.config/tmux/tmux.conf
  $TPM/bin/install_plugins
  mkdir -p $KT
  cp $TP/kitty-vim-tmux-navigator/neighboring_window.py $KT
  cp $TP/kitty-vim-tmux-navigator/pass_keys.py $KT
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
  if [[ `uname -s` == 'Darwin' ]]; then
    require_brew autojump
  elif [[ `uname -s` == 'Linux' ]]; then
    require_apt autojump
  fi
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
