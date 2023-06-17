FROM alpine:3.18

RUN apk update && apk upgrade

RUN apk add \
  git \
  neovim \
  tmux \
  zsh \
  docker-cli \
  python3 \
  py3-pip \
  nodejs \
  npm \
  rust \
  cargo \
  go

RUN apk add \
  g++ \
  curl \
  fzf \
  zoxide \
  stow

RUN <<-EOF
  cargo install tree-sitter-cli
  pip install neovim
EOF

ENV REMOTE=true

RUN <<-EOF
  CONFIG_HOME=$HOME/.config
  DOTS=$HOME/Software/dots

  mkdir ~/Software
  mkdir -p ${CONFIG_HOME}/zsh
  mkdir -p ${CONFIG_HOME}/tmux/plugins
  mkdir -p ${CONFIG_HOME}/lazygit
  mkdir -p ${CONFIG_HOME}/astronvim

  git clone --depth 1 https://github.com/NikoKS/dots                                ${DOTS}
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim                        ${CONFIG_HOME}/nvim
	git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git      ${CONFIG_HOME}/zsh/zsh-syntax-highlighting
	git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git ${CONFIG_HOME}/zsh/zsh-history-substring-search
	git clone --depth 1 https://github.com/softmoth/zsh-vim-mode.git                  ${CONFIG_HOME}/zsh/zsh-vim-mode
	git clone --depth 1 https://github.com/romkatv/powerlevel10k.git                  ${CONFIG_HOME}/zsh/powerlevel10k
	git clone --depth 1 https://github.com/tmux-plugins/tpm.git                       ${CONFIG_HOME}/tmux/plugins/tpm

  cd ${DOTS}
  stow --dotfiles -vt ${CONFIG_HOME} dotfiles
EOF

CMD ["/bin/zsh"]
