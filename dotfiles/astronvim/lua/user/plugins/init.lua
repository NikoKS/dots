return {
	{ "jenterkin/vim-autosource" },
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("user.plugins.nightfox")
		end,
	},
	{
		"justinmk/vim-sneak",
		config = function()
			require("user.plugins.sneak")
		end,
	},
	{
		"tpope/vim-surround",
		config = function()
			require("user.plugins.surround")
		end,
		after = "vim-sneak"
	},
	{
		"tpope/vim-repeat",
		after = "vim-surround"
	},
	{
		"junegunn/vim-easy-align",
		config = function()
			require("user.plugins.align")
		end,
		after = "vim-surround"
	},
	{
		"jpalardy/vim-slime",
		config = function()
			require("user.plugins.slime")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup({ floating_window_above_cur_line = true, hint_enable = false })
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("user.plugins.conflict")
		end,
	},
	-- { "nvim-treesitter/nvim-treesitter-context" }
	-- { "ahmedkhalf/project.nvim" }
	-- { "kylechui/nvim-surround" }
}
