-- Lunarvim config

-- general
lvim.log.level = "warn"
lvim.leader = ";"
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true
vim.o.cmdheight = 1
vim.o.foldlevel = 99
vim.o.timeoutlen = 300
vim.o.updatetime = 250
vim.o.clipboard = ""
vim.o.mouse = ""

-- Additional Plugins
lvim.plugins = {
	{ "EdenEast/nightfox.nvim" },
	{ "justinmk/vim-sneak" },
	{ "tpope/vim-surround" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "vimpostor/vim-tpipeline" },
	{ "NikoKS/vim-tmux-navigator" },
	{ "ray-x/lsp_signature.nvim" },
	{ "michaeljsmith/vim-indent-object" },
	{ "jenterkin/vim-autosource" },
	{ "jpalardy/vim-slime" },
	{ "tpope/vim-fugitive" },
	{ "ntpeters/vim-better-whitespace" },
	{ "nvim-telescope/telescope-live-grep-args.nvim" },
	{ "nvim-treesitter/playground" },
	-- { "liuchengxu/vista.vim" },
}

require("mappings") -- Additional keymappings
require("theme") -- Theme settings
require("treesit") -- Treesitter settings
require("tree") -- lua tree (left sidebar) settings
require("tele") -- telescope settings
require("luali") -- lualine setting
require("lsp-conf") -- lsp, diagnostics, formater, linter settings
require("plugconf") -- Additional Plugins settings
require("functions") -- Additional functions
