" Minpac Plugin Manager
source $HOME/.config/nvim/dotvim/minpac.vim

" Basic Config
set nu
set title
set mouse=a
set autowrite
set expandtab
set tabstop=2
set shiftwidth=2
set shortmess=atI
let mapleader = ";"

" Colorscheme ============================================================={{{
set termguicolors
let g:afterglow_inherit_background=1
autocmd ColorScheme afterglow 
  \ highlight StatusLineNC gui=NONE         guibg=#505050 guifg=#7e8d50 |
  \ highlight StatusLine   gui=bold         guibg=#7e8d50 guifg=#111213 |
  \ highlight Pmenu        gui=NONE         guibg=#505050 guifg=#7e8d50 |
  \ highlight PmenuSel     gui=NONE         guibg=#7e8d50 guifg=#111213 |
  \ highlight Comment      gui=NONE                       guifg=#7dd5cf |
  \ highlight VertSplit                     guibg=#505050               |
  \ highlight Visual                        guibg=#7e8d50 guifg=#111213 |
  \ highlight BadWhitespace                 guibg=#919191 guifg=#919191 |
  \ highlight Folded                                      guifg=#f5f5f5 |
  \ highlight Conceal                                     guifg=#919191 |
  \ highlight Sneak        gui=bold         guibg=#111213 guifg=#8ec43d |
  \ highlight SneakScope                    guibg=#ffa460 guifg=#d0d0d0 |
  \ highlight CocErrorSign                                guifg=#ac4142 |
  \ highlight NonText                                     guifg=#111213 |
  \ highlight CursorColumn                  guibg=#505050               |
  \ highlight CocExplorerNormalFloat        guibg=#111213               |
  \ highlight CocFloating                   guibg=#505050               |
  \ highlight CocExplorerIndentLine                       guifg=#919191 |
  \ highlight SignatureMarkText                           guifg=#7e8d50 
colorscheme afterglow
" }}}

" Plugins settings ========================================================{{{
" Source External Plugins Configs
source $HOME/.config/nvim/dotvim/coc.vim

" Global Plugins Settings
" Python setting
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" vim rooter
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'current'

" fzf related settings
let g:fzf_colors = {
  \ 'bg+':     ['bg', 'CursorColumn'],
  \ 'border':  ['fg', 'Normal']}
let g:fzf_action = {
      \ 'enter': 'buffer'}
let g:coc_fzf_preview =  'right:50%'

" Vim Sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#prompt = '🔎'
let g:sneak#target_labels = 'fjeiwoa;dkslqpurvncmzxbtyASDFGHJKLZXCVBNMQWERTYUIOP,./<>?:"[]{}\|1234567890-=!@#$%^&*()_+`~'

" Vim Marks
let g:SignatureMap = {
  \ 'Leader'             :  "M",
  \ 'PlaceNextMark'      :  "M,",
  \ 'ToggleMarkAtLine'   :  "M.",
  \ 'PurgeMarksAtLine'   :  "M-",
  \ 'PurgeMarks'         :  "M<Space>",
  \ 'PurgeMarkers'       :  "M<BS>",
  \ 'ListBufferMarks'    :  "M/",
  \ 'ListBufferMarkers'  :  "M?"
  \ }

" Tagbar
let g:tagbar_map_togglefold = '<space>'
let g:tagbar_map_close = 'M'
let g:tagbar_sort = 0
let g:tagbar_width = 35

" Nerd Commenter align
let g:NERDDefaultAlign = 'left'

" SimpylFold setting
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

" Hexokinase Setting
let g:Hexokinase_highlighters = [ 'backgroundfull' ]

" IndentLine settings
let g:indentLine_concealcursor = 'n'
let g:indentLine_conceallevel = '1'
let g:indentLine_char_list = ['│','|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['startify', 'json', 'coc-explorer', 'help', 'text', 'vimwiki', 'markdown', 'vim']

" Vimwiki Settings
let g:vimwiki_hl_headers=1
let g:vimwiki_list = [{'path': '~/Drive/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr'
let g:vimwiki_listsyms='    x'
let g:vimwiki_map_prefix='<Leader>v'
let g:vimwiki_key_mappings = {'headers': 0}
autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks

"Guttentags Settings
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')           " put tags in one directory
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1         " Makes sure guttentag generate tags
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [            
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

"multicursor
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-v>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-v>'           " replace visual C-n
let g:VM_maps['Select Operator'] = ''                   " disable select operator
let g:VM_Mono_hl   = 'DiffText'
let g:VM_Extend_hl = 'PmenuSel'
let g:VM_Cursor_hl = 'Visual'
let g:VM_Insert_hl = 'PmenuSel'

" Vimade Settings
let g:vimade = {}
let g:vimade.fadelevel = 0.7
let g:vimade.rowbufsize = 1
autocmd FileType coc-explorer,tagbar VimadeBufDisable 
"}}}

" Additional Settings ====================================================={{{
" Cursorline
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" smart case insensitive
set smartcase
set ignorecase

"Whitespace flaggin
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.html match BadWhitespace /\s\+$/

"Status line
set laststatus=2                             " always show statusbar
set statusline+=%-10.3n\                     " buffer number
set statusline+=%f\                          " filename
set statusline+=%y                           " filetype
set statusline+=%h%m%r%w                     " status flags
set statusline+=%=                           " right align remainder
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position
set fillchars+=vert:\ 
" }}}

" Functions
source $HOME/.config/nvim/dotvim/functions.vim

" Remaps
source $HOME/.config/nvim/dotvim/remaps.vim

"File type and syntax Plugins path:
"~/.config/nvim/ftplugin/python.vim
"~/.config/nvim/ftplugin/vim.vim
"~/.config/nvim/ftplugin/vimwiki.vim
"~/.config/nvim/ftplugin/html.vim
"~/.config/nvim/after/syntax/vimwiki.vim
