vim.cmd([[
  let g:slime_paste_file = tempname()
  let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
]])
vim.g["slime_target"] = "tmux"
vim.g["slime_dont_ask_default"] = 1
vim.g["autosource_disable_autocmd"] = 1
vim.keymap.set('v', 'r', '<Plug>SlimeRegionSend')
vim.keymap.set('n', '<leader>rl', 'Vr', { remap = true })
vim.keymap.set('n', '<leader>rw', '<cmd>SlimeSend0 "cd " . getcwd() . "\\n"<cr>')
