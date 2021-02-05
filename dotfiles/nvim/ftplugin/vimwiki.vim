"These File contains vimwiki specific Settings
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=0
setlocal cole=1
setlocal cocu=n
setlocal wrap
setlocal linebreak

"Vimwiki Table Mapping
nnoremap tg :VimwikiTableMoveColumnLeft<CR>
nnoremap tl :VimwikiTableMoveColumnRight<CR>
nnoremap tm :VimwikiTable 2 2<CR>
nnoremap toc :VimwikiTOC<CR>

"Diary mapping
nnoremap odn :VimwikiDiaryNextDay<CR>
nnoremap odp :VimwikiDiaryPrevDay<CR>

"Header Colors
hi VimwikiHeader1 gui=bold guifg=#8ec43d guibg=NONE
hi VimwikiHeader2 gui=bold guifg=#e0c64f guibg=NONE 
hi VimwikiHeader3 gui=bold guifg=#43a5d5 guibg=NONE
hi VimwikiHeader4 gui=bold guifg=#8b57b5 guibg=NONE
hi VimwikiHeader5 gui=bold guifg=#7dd5cf guibg=NONE
hi VimwikiHeader6 gui=bold guifg=#c22832 guibg=NONE

hi VimwikiTodo gui=bold guifg=#e5b566
hi VimwikiDelText gui=strikethrough guifg=#ac4142
hi VimwikiLink gui=underline guifg=#f5f5f5
hi MyConceal guibg=NONE guifg=#e5b566

" Buffer Specific settings
au BufEnter * if &ft ==# 'vimwiki'
      \ | set winhl=Conceal:MyConceal
      \ | execute "silent! CocDisable"
      \ | endif
au BufLeave * if &ft ==# 'vimwiki'
      \ | set winhl=Conceal:Conceal
      \ | execute "silent! CocEnable"
      \ | endif


