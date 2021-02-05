" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use D to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> D :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"User Added ========================================================

" Install these
let g:coc_global_extensions = ['coc-pyright', 'coc-css', 'coc-html', 'coc-json', 'coc-yaml', 'coc-snippets', 'coc-explorer', 'coc-git']

" Check if there's any selection
"inoremap <expr> <cr> pumvisible() ? coc#rpc#request('hasSelected', []) ? "\<C-y>" : "<CR>" : "\<C-g>u\<CR>"
inoremap <expr> <cr> coc#rpc#request('hasSelected', []) ? "\<C-y>" : "<CR>"

"simplify tab behaviour
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" to go to next snippet
let g:coc_snippet_next = '<CR>'
let g:coc_snippet_prev = '<S-tab>'

" CoC Explorer Settings
augroup MyCocExplorer
  autocmd!
  " set window status line
  autocmd FileType coc-explorer setl statusline=File-Explorer
  "quit explorer whein it's the last
  autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
  " Make sure nothing opened in coc-explorer buffer
  autocmd BufEnter * if bufname('#') =~# "\[coc-explorer\]-." && winnr('$') > 1 | b# | endif
  "open if directory specified or if buffer empty
  autocmd VimEnter * let d = expand('%:p')
    \ | if isdirectory(d)
      \ | silent! bd
      \ | exe 'CocCommand explorer --quit-on-open --position left --sources buffer+,file+ ' . d
    \ | endif
  autocmd User CocExplorerOpenPost let dir = getcwd() | call CocActionAsync("runCommand", "explorer.doAction", "closest", {"name": "cd", "args": [dir]})
augroup END
