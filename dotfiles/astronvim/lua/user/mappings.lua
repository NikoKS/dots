local toggle_term_cmd = astronvim.toggle_term_cmd
return {
	-- first key is the mode
	n = {
		-- Remove mapping
		["q"] = "<nop>", -- <nop> for vim defaults
		[">b"] = false, -- false for remove mapping
		["<b"] = false,
		["<leader>/"] = false,
		["<leader>c"] = false,
		["<leader>C"] = false,
		["<leader>d"] = false,
		["<leader>h"] = false,
		["<leader>o"] = false,
		["<leader>q"] = false,
		["<leader>gt"] = false,
		["<leader>sm"] = false,

		-- General
		["v"] = { "<C-v>" }, -- Visual Block
		["<C-v>"] = { "v" }, -- Visual
		["r"] = { "<C-r>" }, -- Redo
		["U"] = { "J" }, -- Up the line
		["O"] = { "<cmd>lua vim.lsp.buf.hover()<cr>" },
		["<BS>"] = { "<cmd>b#<cr>" }, --
		["<esc>"] = { "<cmd>noh<cr><esc>" },
		["<CR>"] = { "<cmd>lua vim.lsp.buf.definition()<cr>" },
		["R"] = { "<cmd>e<CR>" },
		["#"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>" },
		[">"] = { ">>" },
		["<"] = { "<<" },

		-- Quit
		["qq"] = { ":q<cr>" },
		["qw"] = { "ZZ" },
		["qa"] = { ":qa<CR>" },
		["qe"] = { ":q!<CR>" },
		["qf"] = { "<cmd>Bdelete<cr>" },

		-- Navigation
		["w"] = { "b" },
		["W"] = { "B" },
		["<S-h>"] = { "^" },
		["<S-l>"] = { "$" },
		["J"] = { "Lzz" },
		["K"] = { "Hzz" },
		["("] = { "%" },
		["<tab>"] = { "*:noh<cr><esc>" },
		["<s-tab>"] = { "#:noh<cr><esc>" },


		-- Copy, Delete
		["x"] = { "y", desc = "Copy", remap = true },
		["X"] = { '"+x', desc = "Copy to system", remap = true },
		["yx"] = { "yy", desc = "Copy current line" },
		["dp"] = { '"1p', desc = "paste from delete buffer" },
		["dP"] = { '"1P', desc = "Paste from delete buffer" },
		["yp"] = { '"0p', desc = "paste from copy buffer" },
		["yP"] = { '"0P', desc = "Paste from copy buffer" },
		["'p"] = { '"zp', desc = "paste from ' buffer" },
		["'P"] = { '"zP', desc = "Paste from ' buffer" },
		["'x"] = { '"zy', desc = "copy to ' buffer" },
		["yf"] = { 'ggVG"+y', desc = "Copy entire file" },

		-- Better selection
		["cw"] = { "ciw", desc = "Change word" },
		["cW"] = { "ciW", desc = "Change Word" },
		["dw"] = { "daw", desc = "Delete word" },
		["dW"] = { "daW", desc = "Delete Word" },
		["cn"] = { "cgn", desc = "Copy next" },
		["cN"] = { "cgN", desc = "Copy prev" },
		["yw"] = { "yiw", desc = "Copy word" },
		["yW"] = { "yiW", desc = "Copy Word" },
		["cf"] = { "ggVG", desc = "Change file" },
		["df"] = { "ggVG", desc = "Delete file" },

		-- BufferLine
		["]"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Go to next tab", silent = true },
		["["] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Go to next tab", silent = true },
		["o"] = { "<cmd>BufferLinePick<cr>", desc = "Open Buffer from tab", silent = true },

		-- Search
		["<leader>sw"] = { "*N", desc = "Search Word Under Cursor" },
		["*"] = { "*N", desc = "Search Word Under Cursor" },
		["<leader>st"] = { "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		["<leader>sb"] = { "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },
		["<C-f>"] = { "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		["<leader>;"] = { "<cmd>Telescope resume<cr>", desc = "Resume last search" },

		-- Menu
		["<leader>m"] = { "<cmd>Mason<cr>", desc = "Open Mason" },
		["<leader>a"] = { "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },

		-- Vim Surround
		["sw"] = { "ysiw", desc = "Surround word", remap = true },
		["sW"] = { "ysiW", desc = "Surround Word", remap = true },

		-- Extra Functions
		["<leader>gg"] = {
			function()
				toggle_term_cmd("lazygit -ucd ~/.config/lazygit")
			end,
			desc = "lazygit custom",
		},
	},

	-- Visual
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
	},

	-- Terminal
	t = {
		-- setting a mapping to false will disable it
		-- ["<esc>"] = false,
	},
}
