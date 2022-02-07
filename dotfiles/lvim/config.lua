-- Lunarvim config

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = ";"
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true
vim.cmd('set cmdheight=1')
vim.cmd("set timeoutlen=300")
vim.opt.clipboard = ''

-- Additional Plugins
lvim.plugins = {
  { "EdenEast/nightfox.nvim" },
  { "justinmk/vim-sneak" },
  { "tpope/vim-surround" },
  { "preservim/tagbar" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "vimpostor/vim-tpipeline" },
  { "NikoKS/vim-tmux-navigator" },
  { "ray-x/lsp_signature.nvim" }
  -- { "NikoKS/vim-iterm2-navigator", run = 'make install'},
  -- { "liuchengxu/vista.vim" },
  -- { "svermeulen/vim-macrobatics" }
  -- { "tpope/vim-repeat" }
  -- { "ntpeters/vim-better-whitespace" }
}

require('mappings') -- Additional keymappings
require('theme')    -- Theme settings
require('treesit')  -- Treesitter settings
require('tree')     -- lua tree (left sidebar) settings
require('tele')     -- telescope settings
require('luali')    -- lualine setting
require('lint')     -- linter settings
require('plugconf') -- Additional Plugins settings
require('functions')-- Additional functions
