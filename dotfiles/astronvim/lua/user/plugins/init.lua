return {
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("user.plugins.nightfox")
		end,
	},
	{ "justinmk/vim-sneak",
		config = function()
			require("user.plugins.sneak")
		end,
	},
	{ "tpope/vim-surround" },
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup({ floating_window_above_cur_line = true, hint_enable = false })
		end,
	},
}
