-- Latest stable lvim
-- e8693406babee724dd51293dc6dad10931dbef45

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = ";"
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
vim.cmd('set cmdheight=1')
vim.cmd("set timeoutlen=300")
vim.opt.clipboard = ''

-- Keymaps
require('mappings')

-- line, bar, tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_cursor = true
lvim.builtin.nvimtree.setup.update_cwd = true
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = true
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
lvim.builtin.nvimtree.setup.view.mappings.list = {
  { key = {"<space>"}, cb = tree_cb("edit") },
  { key = {"<esc>"}, cb = tree_cb("close") },
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent = { enable = true, disable = { "python", "yaml", "yml", "sql" } }

-- Additional Plugins
lvim.plugins = {
  { "EdenEast/nightfox.nvim" },
  { "justinmk/vim-sneak" },
  { "tpope/vim-surround" },
  { "NikoKS/vim-iterm2-navigator", run = 'make install'},
  { "preservim/tagbar" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "vimpostor/vim-tpipeline" }
  -- { "liuchengxu/vista.vim" },
  -- { "svermeulen/vim-macrobatics" }
  -- { "tpope/vim-repeat" }
  -- { "ntpeters/vim-better-whitespace" }
}

require('theme')

require('tele')

-- Vim Sneak
-- map Q <Plug>Sneak_;
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

-- vim surrond remmaping
vim.cmd([[
  nmap sw ysiw
  nmap sW ysiW
  vmap s S
]])

require('functions')

-- Lualine
require('luali')

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

-- tpipeline
-- vim.g['tpipeline_preservebg'] = 1

-- require'lspconfig'.sqlls.setup{
--   cmd = {"sql-language-server", "up", "--method", "stdio"};
--   ...
-- }
-- lvim.lang.sql.formatters = { { exe = "sql-formatter"}, args = { "-u" } }
