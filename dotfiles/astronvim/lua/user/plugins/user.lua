return {
	{
		"phaazon/hop.nvim",
		event = "User AstroFile",
		config = function()
			local hop = require("hop")
			local directions = require("hop.hint").HintDirection
			hop.setup({ keys = "etovxqpdygfblzhckisuran" })
			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
			end, { remap = true })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
			end, { remap = true })
		end,
	},
	{
		"tpope/vim-surround",
		event = "User AstroFile",
		config = function()
			vim.keymap.set("x", "s", "<Plug>VSurround")
			vim.keymap.set("n", "s", "<Plug>Ysurround")
		end,
	},
	{
		"tpope/vim-repeat",
		event = "User AstroFile",
		dependencies = { "tpope/vim-surround" },
	},
	{
		"tpope/vim-fugitive",
		event = "User AstroFile",
	},
	{
		"junegunn/vim-easy-align",
		event = "User AstroFile",
		config = function()
			vim.keymap.set("x", "S", "<Plug>(EasyAlign)")
			vim.keymap.set("n", "S", "<Plug>(EasyAlign)")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					ours = "co",
					theirs = "ct",
					none = "c0",
					both = "cb",
					next = "]c",
					prev = "[c",
				},
				disable_diagnostics = true,
			})
		end,
	},
	{
		"jpalardy/vim-slime",
		event = "User AstroFile",
		config = function()
			vim.cmd([[
  		let g:slime_paste_file = tempname()
  		let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
			]])
			vim.g["slime_target"] = "tmux"
			vim.g["slime_dont_ask_default"] = 1
			vim.g["autosource_disable_autocmd"] = 1
			vim.keymap.set("v", "<cr>", "<Plug>SlimeRegionSend")
			vim.keymap.set("n", "<leader>rw", '<cmd>SlimeSend0 "cd " . getcwd() . "\\n"<cr>')
		end,
	},
	{ "jenterkin/vim-autosource", lazy = false },
}
