" Minpac Plugin Manager
source $HOME/.config/nvim/dotvim/minpac.vim

" Basic Config {{{
set nu
set title
set mouse=a
set autowrite
set expandtab
set tabstop=2
set shiftwidth=2
set shortmess=atI
let mapleader = ";"
" }}}

" Colorscheme ============================================================={{{
set termguicolors
let g:afterglow_inherit_background=1
autocmd ColorScheme afterglow 
  \ hi StatusLineNC gui=NONE         guibg=#222222 guifg=#7e8d50 |
  \ hi StatusLine   gui=NONE         guibg=#222222 guifg=#7e8d50 |
  \ hi Pmenu        gui=NONE         guibg=#505050 guifg=#7e8d50 |
  \ hi PmenuSel     gui=NONE         guibg=#7e8d50 guifg=#202020 |
  \ hi Comment      gui=NONE                       guifg=#7dd5cf |
  \ hi javaScriptComment                           guifg=#e5b566 |
  \ hi javaScriptLineComment                       guifg=#7dd5cf |
  \ hi VertSplit    gui=bold         guibg=#202020 guifg=#000000 |
  \ hi Visual                        guibg=#7e8d50 guifg=#202020 |
  \ hi BadWhitespace                 guibg=#919191 guifg=#919191 |
  \ hi Folded                                      guifg=#f5f5f5 |
  \ hi Conceal                                     guifg=#919191 |
  \ hi NonText                                     guifg=#202020 |
  \ hi Sneak        gui=bold         guibg=#202020 guifg=#8ec43d |
  \ hi SneakScope                    guibg=#ffa460 guifg=#d0d0d0 |
  \ hi CursorColumn                  guibg=#505050               |
  \ hi CocFloating                   guibg=#505050               |
  \ hi CocErrorSign                                guifg=#ac4142 |
  \ hi CocExplorerNormalFloat        guibg=#202020               |
  \ hi CocExplorerIndentLine                       guifg=#919191 |
  \ hi CocExplorerFileRoot                         guifg=#7e8d50 |
  \ hi link CocExplorerFileGitRootUnstaged   CocExplorerFileRoot |
  \ hi link CocExplorerFileGitUnstaged       CocExplorerFileRoot |
  \ hi link CocExplorerBufferRoot            CocExplorerFileRoot |
  \ hi CocExplorerFileRootName                     guifg=#6c99bb |
  \ hi SignatureMarkText                           guifg=#7e8d50 
silent! colorscheme afterglow
" }}}

" Plugins settings ========================================================{{{
" Source External Plugins Configs
source $HOME/.config/nvim/dotvim/coc.vim

" Core Plugin Settings {{{
" Python setting
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" vim rooter
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'current'

" Vim Sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#prompt = '🔎'
let g:sneak#target_labels = 'fjewo;dkslqpurvncmzxbtySDFGHJKLZXCVBNMQWERTYUOP,./<>?:"[]{}\|1234567890-=!@#$%^&*()_+`~'

" Nerd Commenter align
let g:NERDDefaultAlign = 'left'

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

" SimpylFold setting
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

" }}}

" fzf related settings
let g:fzf_colors = {
  \ 'bg+':     ['bg', 'CursorColumn'],
  \ 'border':  ['fg', 'Normal']}
let g:fzf_action = {
      \ 'enter': 'buffer'}
let g:coc_fzf_preview =  'right:50%'

" Vim-snippet settings
 let g:ultisnips_python_style='google'

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

" Hexokinase Setting
let g:Hexokinase_highlighters = [ 'backgroundfull' ]

" IndentLine settings
let g:indentLine_concealcursor = 'n'
let g:indentLine_conceallevel = '1'
let g:indentLine_char_list = ['│','|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['startify', 'json', 'coc-explorer', 'help', 'text', 'vimwiki', 'markdown', 'vim', 'man', 'calendar']

" Vimwiki Settings
let g:vimwiki_hl_headers=1
let g:vimwiki_list = [{'path': '~/Drive/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
"let g:vimwiki_folding = 'expr'
let g:vimwiki_listsyms='    x'
let g:vimwiki_map_prefix='<Leader>v'
let g:vimwiki_key_mappings = {'headers': 0}
autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks

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

" Vim Airline Settings
"set noshowmode
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_theme='term'

" LeetCode
let g:leetcode_browser = 'firefox'
"let g:leetcode_solution_filetype = 'javascript'
let g:leetcode_solution_filetype = 'python'
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
set fillchars+=vert:│

"filetype modification
autocmd BufRead,BufNewFile *.ejs set filetype=html
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
