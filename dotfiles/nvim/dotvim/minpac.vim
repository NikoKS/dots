" Normally this if-block is not needed, because `:set nocp` is done
" automatically when .vimrc is found. However, this might be useful
" when you execute `vim -u .vimrc` from the command line.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  " Looks
  call minpac#add('kshenoy/vim-signature')
  call minpac#add('danilo-augusto/vim-afterglow')
  "call minpac#add('itchyny/lightline.vim')
  "call minpac#add('vim-airline/vim-airline')
  "call minpac#add('vim-airline/vim-airline-themes')
  " Folding Commenting Indenting Syntax Utilities
  call minpac#add('tmhedberg/SimpylFold')
  call minpac#add('preservim/nerdcommenter')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('maxmellon/vim-jsx-pretty')
  call minpac#add('cespare/vim-toml')
  " Navigating
  call minpac#add('NikoKS/kitty-vim-tmux-navigator')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('justinmk/vim-sneak')
  "call minpac#add('kyazdani42/nvim-web-devicons')
  "call minpac#add('romgrk/barbar.nvim')
  " Feature
  "call minpac#add('jez/vim-superman')
  call minpac#add('lambdalisue/vim-manpager')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('airblade/vim-rooter')
  call minpac#add('tpope/vim-surround')
  call minpac#add('jiangmiao/auto-pairs')
  call minpac#add('wellle/targets.vim')
  call minpac#add('mhinz/vim-startify')

  " Heavier Plugins {{{
  call minpac#add('Yggdroot/indentLine')
  call minpac#add('TaDaa/vimade')
  call minpac#add('RRethy/vim-hexokinase', { 'do': 'make hexokinase' })

  call minpac#add('mg979/vim-visual-multi')
  call minpac#add('junegunn/fzf', {'do': {-> fzf#install()}})
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('antoinemadec/coc-fzf')

  call minpac#add('preservim/tagbar')
  call minpac#add('vimwiki/vimwiki')
  call minpac#add('tools-life/taskwiki', {'do': {-> system('python3 -m pip install -U -r requirements.txt')}})
  call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})
  call minpac#add('neoclide/coc.nvim')
  call minpac#add('honza/vim-snippets')

  call minpac#add('ianding1/leetcode.vim')
  call minpac#add('itchyny/calendar.vim')
  " }}}

endfunction


" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()
