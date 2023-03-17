return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "lua", "sql" },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						aa = "@parameter.outer",
						ia = "@parameter.inner",
						aA = "@attribute.outer",
						iA = "@attribute.inner",
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "User AstroFile",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-treesitter/nvim-treesitter-refactor",
		event = "User AstroFile",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
