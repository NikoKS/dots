-- Auto Commands
lvim.autocommands = {
	{ "WinEnter", { pattern = { "*" }, command = "setlocal cursorline" } }, -- Cursor line only on active window
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
			command = "if len(expand('%')) != 0 && (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | mkview | endif",
		},
	},
	{
		"BufWinEnter",
		{
			pattern = { "*" },
			command = "if (index(g:indent_blankline_filetype_exclude, &ft)) == -1 | silent! loadview | endif",
		},
	},
}

-- quit if nvimtree is last window
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "q!"
    end
  end
})

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
