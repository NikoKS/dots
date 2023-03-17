local utils = require("astronvim.utils")
local _, luasnip = pcall(require, "luasnip")
local nav = require("nvim-treesitter-refactor.navigation")

return {
	-- first key is the mode
	n = {
		-- Remove Mapping
		["<leader>/"] = false,
		["q"] = "<nop>",   -- <nop> for vim defaults
		-- General/Utility
		["r"] = { "<C-r>" }, -- Redo
		["R"] = { "<cmd>e!<CR>" },
		["#"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>" },
		[" "] = { "za" },
		["<leader>a"] = { "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },
		["?"] = { "<cmd>lua vim.lsp.buf.hover()<cr>" },
		["="] = { "<c-w>=" },
		-- Quit
		["qq"] = { ":q<cr>", silent = true },
		["qw"] = { "ZZ", silent = true },
		["qa"] = { ":qa<CR>", silent = true },
		["qe"] = { ":q!<CR>", silent = true },
		["qf"] = { "<cmd>Bdelete<cr>" },
		-- Navigation
		["w"] = { "b" },
		["W"] = { "B" },
		["<S-h>"] = { "^" },
		["<S-l>"] = { "$" },
		["J"] = { "<C-d>", remap = true },
		["K"] = { "<C-u>", remap = true },
		["}"] = { "]b", remap = true },
		["{"] = { "[b", remap = true },
		["<bs>"] = { "<c-o>", desc = "Jump to last position" },
		["[w"] = { "#", desc = "Jump to previous word match" },
		["]w"] = { "*", desc = "Jump to next word match" },
		["U"] = { "J" }, -- Up the line
		["M"] = { "zz" },
		["b"] = { "<cmd>b#<cr>" },
		-- Search
		["<C-f>"] = { "<cmd>Telescope find_files<cr>", desc = "Find File" },
		["<leader>ff"] = { "<cmd>Telescope resume<cr>", desc = "Resume last search" },
		["<leader>fd"] = { "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostic" },
		-- Copy, Delete
		["x"] = { "y", desc = "Copy", remap = true },
		["X"] = { '"+x', desc = "Copy to system", remap = true },
		["Xp"] = { '"+p', desc = "Paste from system" },
		["yx"] = { "yy", desc = "Copy current line" },
		["yp"] = { '"0p', desc = "paste from copy buffer" },
		["yP"] = { '"0P', desc = "Paste from copy buffer" },
		["yf"] = { "<cmd>%y+<cr>", desc = "Copy entire file" },
		["df"] = { "<cmd>%d<cr>", desc = "Copy entire file" },
		-- Macros
		["m"] = { "q" },
		[","] = { "Q" },
		-- Extra Functions
		["<leader>gg"] = {
			function()
				utils.toggle_term_cmd("lazygit -ucd ~/.config/lazygit")
			end,
			desc = "Lazygit",
		},
		["<leader>ld"] = {
			function()
				utils.toggle_term_cmd("lazydocker")
			end,
			desc = "LazyDocker",
		},
		["<CR>"] = {
			function()
				if vim.bo.filetype == "man" or vim.bo.filetype == "help" then
					vim.cmd('execute "tag " . expand("<cword>")')
				else
					vim.cmd("Telescope lsp_definitions")
				end
			end,
		},
		["<esc>"] = {
			function()
				require("notify").dismiss()
			end,
		},
		["<tab>"] = {
			function()
				if luasnip.jumpable() then
					luasnip.jump(1)
				else
					nav.goto_next_usage()
				end
			end,
		},
		["<s-tab>"] = {
			function()
				nav.goto_previous_usage()
			end,
		},
	},
	v = {
		-- Remove Mapping
		["<leader>/"] = false,
		-- Navigation
		["w"] = { "b" },
		["W"] = { "B" },
		["<S-h>"] = { "^" },
		["<S-l>"] = { "$" },
		["J"] = { "Lzz" },
		["K"] = { "Hzz" },
		-- Copy
		["x"] = { "y", desc = "Copy", remap = true },
		["X"] = { '"+x', desc = "Copy", remap = true },
		-- Comment
		["#"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" },
		-- Macros
		[","] = { ":'<,'>normal! Q<cr>" },
	},
}
