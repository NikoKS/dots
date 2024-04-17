return {
	{
		"smoka7/hop.nvim",
		event = "User AstroFile",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		keys = {
			{
				"f",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.AFTER_CURSOR,
						current_line_only = false,
					})
				end,
				mode = { "n", "x" },
				desc = "Hop char 1 forward",
			},
			{
				"F",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
						current_line_only = false,
					})
				end,
				mode = { "n", "x" },
				desc = "Hop char 1 backward",
			},
		},
	},
	{
		"tpope/vim-fugitive",
		event = "User AstroFile",
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
	{
		"Exafunction/codeium.vim",
		event = "User AstroFile",
		config = function()
			vim.keymap.set("i", "<S-CR>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
			vim.keymap.set("n", "<leader>;", function()
				if vim.g.codeium_enabled == true then
					vim.cmd("CodeiumDisable")
				else
					vim.cmd("CodeiumEnable")
				end
			end, { noremap = true, desc = "Toggle Codeium active" })
		end,
	},
	{
		"anurag3301/nvim-platformio.lua",
		event = "User AstroFile",
		dependencies = {
			{ "akinsho/nvim-toggleterm.lua" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	},
}
