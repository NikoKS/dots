" syntac
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command! WhatSyntax call SynStack()

" SmartJump
function! SmartJump()
  "if filereadable(expand(expand("<cfile>")))
  "  silent edit <cfile>
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

nnoremap <silent> <cr> :call SmartJump()<CR>


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
