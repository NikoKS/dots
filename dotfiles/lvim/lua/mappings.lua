-- Unmaping. Unfortunately need to do this since Lvim has a lot of default mappings
lvim.keys.normal_mode["<S-l>"] = nil
lvim.keys.normal_mode["<S-h>"] = nil
lvim.keys.normal_mode["[q"] = nil
lvim.keys.normal_mode["]q"] = nil
lvim.keys.visual_block_mode["J"] = nil
lvim.keys.visual_block_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["gI"] = nil
vim.api.nvim_set_keymap('n', '[%', '<nop>', {})
vim.api.nvim_set_keymap('n', ']%', '<nop>', {})
vim.cmd([[map Q <Nop>]])
lvim.builtin.which_key.setup.triggers_blacklist = {
  n = {"[", "]"}
}

-- change lsp functions to use telescope
lvim.lsp.buffer_mappings.normal_mode["gd"] = {  ":Telescope lsp_definitions<CR>", "Goto Definition"}
lvim.lsp.buffer_mappings.normal_mode["gi"] = {  ":Telescope lsp_implementations<CR>", "Goto Implemetation"}
lvim.lsp.buffer_mappings.normal_mode["gr"] = {  ":Telescope lsp_references<CR>", "Goto References"}

-- Extra commands
vim.cmd([[
  nnoremap <silent> <esc> :noh<return><esc>
  nnoremap <silent> R :e<CR>
]])
lvim.builtin.which_key.mappings["v"] = { ":vs<CR>" , "VerticalSplit"}
lvim.builtin.which_key.mappings[";"] = {":Telescope resume<cr>" , "Resume last search"}
lvim.builtin.which_key.mappings["q"] = {":q<cr>", "Quit"}
lvim.builtin.which_key.mappings["Q"] = {":q!<cr>", "Quit Without Saving"}
lvim.builtin.which_key.mappings["sm"] = {":Telescope marks <CR>", "Search Marks"}
lvim.builtin.which_key.mappings["ss"] = {":Telescope lsp_document_symbols <CR>", "Search Symbols"}
lvim.builtin.which_key.mappings["r"] = {
  name = "Run",
  -- p = { ":w<cr>:TermExec cmd='python3 %'<cr>" , "Run Python" }
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
  nnoremap o J
  nnoremap gm %
  nmap ;n <c-g>
  nmap # ;/
  vmap # ;/
  nmap M zz
]])
lvim.builtin.which_key.mappings["n"] = 'Print File Name'

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
  nnoremap cf ggVGc
  nnoremap df ggVGd
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
  nnoremap xf ggVG"+y
]])

-- Navigation keymappings
vim.cmd([[
  nmap <silent> <tab> *<esc>
  vmap <silent> <tab> *<esc>
  nnoremap <silent> <s-tab> #:noh<return><esc>
  vnoremap <silent> <s-tab> #:noh<return><esc>
  nnoremap ( %
  vnoremap ( %
  nnoremap 'i gi
  nmap <BS> ;bb
  nmap <C-o> ;bf
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
  imap <C-h> <esc><C-h>
  imap <C-j> <esc><C-j>
  imap <C-k> <esc><C-k>
  imap <C-l> <esc><C-l>
]])
