-- Auto Commands
lvim.autocommands.custom_groups = {
  { "WinEnter", "*", "setlocal cursorline" },
  { "WinLeave", "*", "if &ft !=# 'NvimTree' | setlocal nocursorline | endif" },
  { "TermLeave", "*", "if (winnr('$') == 1 && len(expand('%')) == 0) | nmap <buffer> <esc> :quit<cr>| endif" },
  { "CursorHold", "*", "lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})"},
  { "WinEnter", "*", "if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | execute 'IndentBlanklineEnable' | endif" },
  { "WinLeave", "*", "IndentBlanklineDisable" },
}

-- Smart Enter
vim.cmd([[
  function! Smart_enter()
    let l:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    let l:fname = expand(expand('<cfile>'))
    let l:lsp = luaeval("vim.inspect(vim.lsp.buf_get_clients()) ~= '{}'")
    if &diff
      exec "diffput"
    elseif l:uri != ""
      silent exec "!open '".l:uri."'"
    elseif filereadable(l:fname)
      normal gf
    elseif l:lsp
      normal gd
    else
      normal *
    endif
  endfunction
  nmap <silent> <CR> :call Smart_enter()<cr>

  function! Visual_smart_enter()
    if &diff
      exec "'<,'>diffput"
    endif
  endfunction

  vmap <silent> <CR> :call Visual_smart_enter()<cr>
]])

-- visual-at.vim
vim.cmd([[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])

-- Macros
-- vim.cmd([[
--   function! Smart_space()
--     if !v:hlsearch
--       normal @q
--     else
--       normal .
--     endif
--   endfunction
--   function Smart_cw()
--     if !v:hlsearch
--       normal ciw
--     else
--       normal cgn
--     endif
--   endfunction
--   nmap <silent> cw :call Smart_cw()<cr>
-- ]])
