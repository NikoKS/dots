-- Auto Commands
-- lvim.autocommands.custom_groups = {
-- 	{ "WinEnter", "*", "setlocal cursorline" },
-- 	{ "WinLeave", "*", "if &ft !=# 'NvimTree' | setlocal nocursorline | endif" },
-- 	{ "TermLeave", "*", "if (winnr('$') == 1 && len(expand('%')) == 0) | nmap <buffer> <esc> :quit<cr>| endif" },
-- 	{ "CursorHold", "*", "lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})" },
-- 	{
-- 		"WinEnter",
-- 		"*",
-- 		"if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | execute 'IndentBlanklineEnable' | endif",
-- 	},
-- 	{ "WinLeave", "*", "IndentBlanklineDisable" },
-- 	{ "BufWinLeave", "*", "if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | mkview | endif" },
-- 	{ "BufWinEnter", "*", "if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | silent! loadview | endif" },
-- }
lvim.autocommands = {
	{ "WinEnter", { pattern = { "*" }, command = "setlocal cursorline" } },
	{ "WinLeave", { pattern = { "*" }, command = "if &ft !=# 'NvimTree' | setlocal nocursorline | endif" } },
	{
		"TermLeave",
		{
			pattern = { "*" },
			command = "if (winnr('$') == 1 && len(expand('%')) == 0) | nmap <buffer> <esc> :quit<cr>| endif",
		},
	},
	{
		"CursorHold",
		{
			pattern = { "*" },
			command = "lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})",
		},
	},
	{
		"WinEnter",
		{
			pattern = { "*" },
			command = "if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | execute 'IndentBlanklineEnable' | endif",
		},
	},
	{ "WinLeave", { pattern = { "*" }, command = "IndentBlanklineDisable" } },
	{
		"BufWinLeave",
		{
			pattern = { "*" },
			command = "if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | mkview | endif",
		},
	},
	{
		"BufWinEnter",
		{
			pattern = { "*" },
			command = "if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | silent! loadview | endif",
		},
	},
	{
		"BufEnter",
		{
			pattern = { "*" },
			command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
		},
	},
}

-- Smart Enter
-- let l:lsp = luaeval("vim.inspect(vim.lsp.buf_get_clients()) ~= '{}'")
vim.cmd([[
  function! Smart_enter()
    let l:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    let l:fname = expand(expand('<cfile>'))
    if &diff
      exec "diffput"
    elseif l:uri != ""
      silent exec "!open '".l:uri."'"
    elseif filereadable(l:fname)
      normal gf
    elseif &ft == 'man'
      silent execute "tag " . expand('<cword>')
    else
      normal gd
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
