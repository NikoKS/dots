-- Unmaping. Unfortunately need to do this since Lvim has a lot of default mappings
lvim.keys.normal_mode["<S-l>"] = nil
lvim.keys.normal_mode["<S-h>"] = nil
lvim.keys.normal_mode["[q"] = nil
lvim.keys.normal_mode["]q"] = nil
lvim.keys.visual_block_mode["J"] = nil
lvim.keys.visual_block_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["gI"] = nil
vim.api.nvim_set_keymap("n", "[%", "<nop>", {})
vim.api.nvim_set_keymap("n", "]%", "<nop>", {})
vim.cmd([[map Q <nop>]])
vim.cmd([[map q <nop>]])
lvim.builtin.which_key.setup.triggers_blacklist = {
	n = { "[", "]" },
}

-- change lsp functions to use telescope
lvim.lsp.buffer_mappings.normal_mode["gd"] = { ":Telescope lsp_definitions<CR>", "Goto Definition" }
lvim.lsp.buffer_mappings.normal_mode["gi"] = { ":Telescope lsp_implementations<CR>", "Goto Implemetation" }
lvim.lsp.buffer_mappings.normal_mode["gr"] = { ":Telescope lsp_references<CR>", "Goto References" }

-- Extra commands
vim.cmd([[
  nnoremap <silent> <esc> :noh<return><esc>
  nnoremap <silent> R :e<CR>
]])
lvim.builtin.which_key.mappings["bv"] = { ":vnew<CR>", "VerticalSplit" }
lvim.builtin.which_key.mappings["bs"] = { ":new<CR>", "Split" }
lvim.builtin.which_key.mappings["bn"] = { ":enew<CR>", "New Empty Buffer" }
lvim.builtin.which_key.mappings[";"] = { ":Telescope resume<cr>", "Resume last search" }
lvim.builtin.which_key.mappings["q"] = { ":q<cr>", "Quit" }
lvim.builtin.which_key.mappings["Q"] = { ":q!<cr>", "Quit Without Saving" }
lvim.builtin.which_key.mappings["sm"] = { ":Telescope marks <CR>", "Search Marks" }
lvim.builtin.which_key.mappings["ss"] = { ":Telescope lsp_document_symbols <CR>", "Search Symbols" }
lvim.builtin.which_key.mappings["sw"] = { ":lua require('tele').file_contains() <CR>", "Search File That Contains" }
lvim.builtin.which_key.mappings["sa"] = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Live Grep with args" }
lvim.builtin.which_key.mappings["pc"] = { ":PackerClean<CR>", "Clean" }
lvim.builtin.which_key.mappings["lR"] = { ":LspRestart<CR>", "Restart LSP" }
lvim.builtin.which_key.mappings["r"] = { name = "Run", }

-- change lazygit exec
lvim.builtin.terminal.execs = {
	{ "lazygit -ucd ~/.config/lazygit", ";gg", "LazyGit" },
}

-- General Keymaps
vim.cmd([[
  map T @
  noremap t q
  map <space> za
  nnoremap v <C-v>
  nnoremap r <C-r>
  nnoremap O J
  nmap o ;bj
  nnoremap gm %
  nmap ;n <c-g>
  nmap # ;/
  vmap # ;/
  nmap M zz
  nnoremap dt :windo diffthis<cr>
]])
lvim.builtin.which_key.mappings["n"] = "Print File Name"

-- Quit and write shortcuts
vim.cmd([[
  nnoremap qw ZZ
  nnoremap qq :q<CR>
  nnoremap qa :qa<CR>
  nnoremap qe :q!<CR>
  nnoremap qd :windo diffoff<cr>
  nnoremap <silent> qf :BufferKill<CR>
]])

-- Sensible selection
vim.cmd([[
  nnoremap * *''
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
  map X "+x
  nnoremap dp "1p
  nnoremap dP "1P
  nnoremap yp "0p
  nnoremap yP "0P
  nnoremap 'p "zp
  nnoremap 'P "zP
  noremap 'x "zy
  nnoremap yf ggVG"+y
  vnoremap <M-c> "+y
  vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>
]])

-- Navigation keymappings
vim.cmd([[
  nnoremap <silent> <tab> *:noh<return><esc>
  vnoremap <silent> <tab> *:noh<return><esc>
  nnoremap <silent> <s-tab> #:noh<return><esc>
  vnoremap <silent> <s-tab> #:noh<return><esc>
  nnoremap ( %
  vnoremap ( %
  nnoremap 'i gi
  nmap <BS> :b#<cr>
  nmap <C-f> ;bf
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
  nnoremap <silent> <nowait> [ :BufferLineCyclePrev<cr>
  nnoremap <silent> <nowait> ] :BufferLineCycleNext<cr>
  nnoremap <silent> <nowait> { :BufferLineMovePrev<cr>
  nnoremap <silent> <nowait> } :BufferLineMoveNext<cr>
  nnoremap <silent> ;bl :BufferLineCloseRight<cr>
  nnoremap <silent> ;bg :BufferLineCloseLeft<cr>
  imap <C-h> <esc><C-h>
  imap <C-j> <esc><C-j>
  imap <C-k> <esc><C-k>
  imap <C-l> <esc><C-l>
]])

-- diff keymappings
vim.cmd([[
  nmap dg :diffget<cr>
  nmap du :diffput<cr>
]])

-- fold keymappings
lvim.builtin.which_key.mappings["f"] = {
	name = "Fold",
	a = { "zM", "Fold All" },
	o = { "zR", "Open All Fold" },
}

-- which_key labeling
local wk = require("which-key")
wk.register({
	w = "Delete word",
	W = "Delete Word",
	b = "Delete indent block",
	f = "Delete file buffer",
	p = "paste from delete buffer",
	P = "Paste from delete buffer",
	s = "Delete surround",
	g = "Get Diff",
	u = "Use Diff",
	t = "Diff between two windows",
}, { prefix = "d" })

wk.register({
	w = "Change word",
	W = "Change Word",
	b = "Change indent block",
	f = "Change file buffer",
	n = "Change next highlighted word",
	N = "Change previous highlighted word",
}, { prefix = "c" })

wk.register({
	b = "Copy indentation block",
	w = "Copy word",
	W = "Copy Word",
	p = "paste from copy buffer",
	P = "Paste from copy buffer",
	f = "Copy whole file",
}, { prefix = "y" })
