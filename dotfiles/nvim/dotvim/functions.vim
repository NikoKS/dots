" Core Functions {{{
" syntax
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command! WhatSyntax call SynStack()

" Quit Buffer
function! BufferWipe()
  if &modified
    echo "Buffer is modified! Save it first."
  else
    b#
    bw#
  endif
endfunc

nnoremap qb :call BufferWipe()<CR>

" SmartJump
function SmartJump()
  if execute("silent! normal gf") !~ "E...:"
    echo "Opened file"
    return v:true
  elseif execute("silent! normal \<C-]>") !~ "E...:"
    return v:true
  else
    call searchdecl(expand('<cword>'))
  endif
endfunc

nnoremap <silent> <cr> :call SmartJump()<CR>
" }}}

" SmartJump
function! SmartJump()
  if execute("silent! normal gf") !~ "E...:"
    echo "Opened file"
    return v:true
  elseif CocHasProvider('definition')
    if CocAction('jumpDefinition')
      return v:true
    endif
  endif

  if execute("silent! normal \<C-]>") !~ "E...:"
    return v:true
  else
    call searchdecl(expand('<cword>'))
  endif
endfunc



