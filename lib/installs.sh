# Compilation of script to install software from source

function version_greater_equal() {
  printf '%s\n' "$2" "$1" | sort -V -C
}

function install_nvim() {
  function install() {
    mkdir -p $1
    info "entering $1"
    pushd $1
    info "removing apt installation of neovim"
    sudo apt purge neovim
    lastversion --asset neovim/neovim --filter appimage$ -d
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
    info "moved appimage to /usr/local/bin/"
    cd ..
    rm -r nvim
    info "leaving $1"
    popd
    ok
  }
  action "check if already on latest version"
  if hash nvim 2> /dev/null; then
    info "neovim detected"
    nvim_ver=`nvim --version | head -n 1 | cut -d v -f 2`
    latest=`lastversion neovim/neovim`
    if version_greater_equal $nvim_ver $latest; then
      ok "Already running latest version of nvim"
    else
      info "Newer version found"
      running "upgrading neovim from source"
      install $1
    fi
  else
    info "neovim not detected"
    running "installing neovim from source"
    install $1
  fi
}

function install_tmux() {
  function install() {
    mkdir -p $1
    info "entering $1"
    pushd $1
    require_apt make
    require_apt bison
    require_apt autoconf
    require_apt automake
    require_apt pkg-config
    require_apt libevent-dev
    require_apt build-essential
    require_apt libncurses5-dev
    require_apt libncursesw5-dev
    info "removing apt installation of tmux"
    sudo apt purge tmux
    lastversion --asset tmux/tmux -d
    tar --strip-components=1 -xvzf tmux*.tar.gz
    ./configure
    make && sudo make install
    info "leaving $1"
    popd
    ok
  }
  action "check if already running latest version of tmux"
  if hash tmux 2> /dev/null; then
    info "tmux detected"
    tmux_ver=`tmux -V | cut -d \  -f 2`
    latest=`lastversion tmux/tmux`
    if version_greater_equal $tmux_ver $latest; then
      ok "Already running latest version of tmux"
    else
      info "Newer version found"
      running "upgrading tmux from source"
      install $1
    fi
  else
    info "tmux not dtected"
    running "installing tmux from source"
    install $1
  fi
}

function install_kitty() {
  function install() {
    mkdir -p $1
    info "entering $1"
    pushd $1
    require_apt libtool
    require_apt pkg-config
    require_apt build-essential
    require_apt autoconf
    require_apt libfreetype6-dev
    require_apt libglib2.0-dev
    require_apt libcairo2-dev
    info "removing apt installation of kitty"
    sudo apt purge kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh \
      | sh /dev/stdin
    git clone --depth 1 https://github.com/harfbuzz/harfbuzz.git /tmp/harfbuzz
    cd /tmp/harfbuzz
    ./autogen.sh && ./configure && make
    cp src/.libs/libharfbuzz.so ~/.local/kitty.app/lib/libharfbuzz.so.0
    info "leaving $1"
    popd
    ok
  }
  action "check if already running latest version of kitty"
  if hash kitty 2> /dev/null; then
    info "kitty detected"
    kitty_ver=`kitty --version | cut -d \  -f 2`
    latest=`lastversion kovidgoyal/kitty`
    if version_greater_equal $kitty_ver $latest; then
      ok "Already running latest version of kitty"
    else
      info "Newer version found"
      running "upgrading kitty from source"
      install $1
    fi
  else
    info "kitty not dtected"
    running "installing kitty from source"
    install $1
  fi
}
