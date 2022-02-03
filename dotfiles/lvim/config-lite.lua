-- Lunarvim lite config for remote server
-- For fzf not found problem, run:
-- :! cd $LUNARVIM_RUNTIME_DIR/site/pack/packer/start/telescope-fzf-native.nvim && make clean && make
-- Discussion: https://github.com/LunarVim/LunarVim/issues/1804


-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = ";"
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
vim.cmd('set cmdheight=1')
vim.cmd("set timeoutlen=300")
vim.opt.clipboard = ''

-- Additional Plugins
lvim.plugins = {
  { "EdenEast/nightfox.nvim" },
  { "justinmk/vim-sneak" },
  { "tpope/vim-surround" },
}

-- require('mappings') -- Additional keymappings
-- require('theme')    -- Theme settings
-- require('treesit')  -- Treesitter settings
-- require('tree')     -- lua tree (left sidebar) settings
-- require('tele')     -- telescope settings
-- require('luali')    -- lualine setting
-- require('lint')     -- linter settings
-- require('plugconf') -- Additional Plugins settings
-- require('functions')-- Additional functions
