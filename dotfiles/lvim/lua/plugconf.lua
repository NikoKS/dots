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

-- Tagbar
lvim.builtin.which_key.mappings["m"] = { ":TagbarToggle<cr>" , "Map"}
vim.g['tagbar_map_togglefold'] = '<space>'
vim.g['tagbar_compact'] = 1

-- blankline
vim.g['indent_blankline_show_current_context'] = vim.v['true']
vim.g['indent_blankline_use_treesitter'] = true
vim.g['indent_blankline_show_first_indent_level'] = false
vim.g['indent_blankline_filetype_exclude'] = {'help', 'NvimTree', 'vista_kind', 'dashboard', 'man', 'toggleterm', 'pakcer', 'tagbar'}

-- vim terminal
lvim.builtin.terminal.float_opts.border = 'shadow'
lvim.builtin.terminal.float_opts.width = 200
lvim.builtin.terminal.float_opts.height = 100
