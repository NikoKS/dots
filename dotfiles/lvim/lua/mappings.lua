-- Unmaping. Unfortunately need to do this since Lvim has a lot of default mappings
lvim.keys.normal_mode["<S-l>"] = nil
lvim.keys.normal_mode["<S-h>"] = nil
lvim.keys.normal_mode["[q"] = nil
lvim.keys.normal_mode["]q"] = nil
lvim.keys.visual_block_mode["J"] = nil
lvim.keys.visual_block_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
vim.api.nvim_set_keymap('n', '[%', '<nop>', {})
vim.api.nvim_set_keymap('n', ']%', '<nop>', {})
lvim.builtin.which_key.setup.triggers_blacklist = {
  n = {"[", "]"}
}

-- change lazygit exec
lvim.builtin.terminal.execs = {
  {"lazygit -ucd ~/.config/lazygit", ";gg", "LazyGit"}
}

-- General Keymaps
vim.cmd([[
  map <silent> <space> @@
  nnoremap v <C-v>
  nnoremap r <C-r>
  nnoremap <BS> J
  nnoremap gm %
  nmap ;n <c-g>
  nmap <tab> %
  nmap # ;/
  vmap # ;/
]])

-- Extra commands
vim.cmd([[
  nnoremap <silent> <esc> :noh<return><esc>
  nnoremap <silent> R :e<CR>
]])
lvim.builtin.which_key.mappings["v"] = { ":vs<CR>" , "VerticalSplit"}
lvim.builtin.which_key.mappings["r"] = {":w<cr>:TermExec cmd='python3 %'<cr>" , "RunPython"}

-- Sensible selection
vim.cmd([[
  nnoremap cw ciw
  nnoremap cW ciW
  nnoremap dw daw
  nnoremap dW daW
  nnoremap cn cgn
  nnoremap cN cgN
  nnoremap yw yiw
  nnoremap yW yiW
  nnoremap ca ggVGc
  nnoremap da ggVGd
]])

-- Remap copy paste
vim.cmd([[
  map x y
  map " "+
  nnoremap dp "1p
  nnoremap dP "1P
  nnoremap xp "0p
  nnoremap xP "0P
  nnoremap 'p "zp
  nnoremap 'P "zP
  noremap 'x "zy
  nnoremap xa ggVG"+y
]])

-- Navigation keymappings
vim.cmd([[
  nmap t ;bb
  nmap T ;bf
  nnoremap J Lzz
  vnoremap J Lzz
  nnoremap K Hzz
  vnoremap K Hzz
  nnoremap L $
  vnoremap L $
  nnoremap H ^
  vnoremap H ^
  nnoremap w b
  vnoremap w b
  nnoremap W B
  vnoremap W B
  nnoremap <nowait> > >>
  nnoremap <nowait> < <<
  nnoremap <silent> <nowait> [ :BufferPrevious<cr>
  nnoremap <silent> <nowait> ] :BufferNext<cr>
  nnoremap <silent> <nowait> { :BufferMovePrevious<cr>
  nnoremap <silent> <nowait> } :BufferMoveNext<cr>
]])