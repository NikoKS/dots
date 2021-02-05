# Compilation of script to install software from source

source ./echos.sh
source ./requires.sh


function install_nvim() {
  action "installing neovim from source"
  mkdir -p $1
  info "entering $1"
  pushd $1
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

function install_tmux() {
  action "installing tmux from source"
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

function install_kitty() {
  action "installing kitty from source"
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
