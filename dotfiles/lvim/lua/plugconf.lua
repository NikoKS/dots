-- Vim Sneak
vim.cmd([[
  let g:sneak#label = 1
  let g:sneak#use_ic_scs = 1
  let g:sneak#prompt = '🔎'
  let g:sneak#target_labels = 'fjewo;dkslqpurvncmzxbtySDFGHJKLZXCVBNMQWERTYUOP,./<>?:"[]{}\|1234567890-=!@#$%^&*()_+`~'
  nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
  nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
  xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
  xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
  onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
  onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
]])

-- vim surround
vim.cmd([[
  nmap sw ysiw
  nmap sW ysiW
  vmap s S
]])

-- vim indentation block selection
vim.cmd([[
  nmap xb yai
  nmap cb cai
  nmap db dai
  nmap vb vai
]])

-- vim slime
vim.cmd([[
  let g:slime_target = "tmux"
  let g:slime_paste_file = tempname()
  let g:slime_default_config = {"socket_name": "default", "target_pane": "{down-of}"}
  let g:slime_dont_ask_default = 1
  xmap r <Plug>SlimeRegionSend
  nmap ;rl Vr
]])
lvim.builtin.which_key.mappings["rl"] = 'Send Line'

-- Tagbar
-- lvim.builtin.which_key.mappings["m"] = { ":TagbarOpen<cr>" , "Map"}
-- vim.g['tagbar_map_togglefold'] = '<space>'
-- vim.g['tagbar_compact'] = 1
-- vim.g['tagbar_autoclose'] = true

-- blankline
vim.g['indent_blankline_show_current_context'] = vim.v['true']
vim.g['indent_blankline_use_treesitter'] = true
vim.g['indent_blankline_show_first_indent_level'] = false
vim.g['indent_blankline_filetype_exclude'] = {'help', 'NvimTree', 'vista_kind', 'dashboard', 'man', 'toggleterm', 'pakcer', 'tagbar', 'lspinfo', 'lsp-installer', 'packer'}

-- vim terminal
lvim.builtin.terminal.float_opts.border = ''
local function width ()
  return math.floor(tonumber(vim.o.columns) * 1)
end
local function height ()
  return math.floor(tonumber(vim.o.lines) * 1)
end
lvim.builtin.terminal.float_opts.width = width
lvim.builtin.terminal.float_opts.height = height

-- lsp_signature
require "lsp_signature".setup({
  floating_window_above_cur_line = true,
  hint_enable = false
})
