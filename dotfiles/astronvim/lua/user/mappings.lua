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
		["<leader>gl"] = false,
		["<leader>gp"] = false,
		["<leader>lD"] = false,
		["<leader>li"] = false,
		["<leader>lR"] = false,
		["<leader>lG"] = false,
		["<leader>lS"] = false,
		["<leader>ls"] = false,
		["<leader>l"] = false,

		-- General
		["v"]     = { "<C-v>" }, -- Visual Block
		["<C-v>"] = { "v" }, -- Visual
		["r"]     = { "<C-r>" }, -- Redo
		["U"]     = { "J" }, -- Up the line
		["O"]     = { "<cmd>lua vim.lsp.buf.hover()<cr>" },
		["<esc>"] = { "<cmd>noh<cr><esc>" },
		["R"]     = { "<cmd>e!<CR>" },
		["#"]     = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>" },
		[">"]     = { ">>" },
		["<"]     = { "<<" },

		-- Quit
		["qq"] = { ":q<cr>" },
		["qw"] = { "ZZ" },
		["qa"] = { ":qa<CR>" },
		["qe"] = { ":q!<CR>" },
		["qf"] = { "<cmd>Bdelete<cr>" },

		-- Navigation
		["w"]       = { "b" },
		["W"]       = { "B" },
		["<S-h>"]   = { "^" },
		["<S-l>"]   = { "$" },
		["J"]       = { "<C-d>", remap = true },
		["K"]       = { "<C-u>", remap = true },
		["("]       = { "%" },
		["<tab>"]   = { "*:noh<cr><esc>" },
		["<s-tab>"] = { "#:noh<cr><esc>" },
		["M"] = { "zz", remap = true },
		["<BS>"]      = { "<C-o>" },
		["\\"]      = { "<C-i>" },

		-- Copy, Delete
		["x"]  = { "y", desc = "Copy", remap = true },
		["X"]  = { '"+x', desc = "Copy to system", remap = true },
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
		-- ["cw"] = { "ciw", desc = "Change word" },
		-- ["cW"] = { "ciW", desc = "Change Word" },
		-- ["dw"] = { "daw", desc = "Delete word" },
		-- ["dW"] = { "daW", desc = "Delete Word" },
		["cn"] = { "cgn", desc = "Copy next" },
		["cN"] = { "cgN", desc = "Copy prev" },
		-- ["yw"] = { "yiw", desc = "Copy word" },
		-- ["yW"] = { "yiW", desc = "Copy Word" },
		["cf"] = { "ggVGc", desc = "Change file" },
		["df"] = { "ggVGd", desc = "Delete file" },

		-- BufferLine
		["]"]         = { "<cmd>BufferLineCycleNext<cr>", desc = "Go to next tab", silent = true },
		["["]         = { "<cmd>BufferLineCyclePrev<cr>", desc = "Go to next tab", silent = true },
		["<leader>]"] = { "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffer to the right", silent = true },
		["<leader>["] = { "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffer to the left", silent = true },
		["o"]         = { "<cmd>BufferLinePick<cr>", desc = "Open Buffer from tab", silent = true },

		-- Search
		["<leader>sw"] = { "*N", desc = "Search Word Under Cursor" },
		["*"]          = { "*N", desc = "Search Word Under Cursor" },
		["<leader>st"] = { "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		["<leader>sb"] = { "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },
		["<C-f>"]      = { "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		["<leader>;"]  = { "<cmd>Telescope resume<cr>", desc = "Resume last search" },
		["<leader>ss"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search Session" },

		-- File
		["<leader>fb"] = false,
		["<leader>fc"] = false,
		["<leader>fF"] = false,
		["<leader>fh"] = false,
		["<leader>fm"] = false,
		["<leader>fW"] = false,
		["<leader>fs"] = { "<cmd>vert split<cr>", desc = "Split" },
		["<leader>ff"] = { function() vim.lsp.buf.format(astronvim.lsp.format_opts) end, desc = "Format" },
		["<leader>fw"] = { "<cmd>w<cr>", desc = "Format and Write" },
		["<leader>fd"] = { "<cmd>diffthis<cr>", desc = "Diff current split" },
		["<leader>fp"] = { "<cmd>!ls %:p<cr>", desc = "Print fullpath" },
		["<leader>fo"] = { "<cmd>diffoff!<cr>", desc = "Exit Diff mode" },
		["<leader>w"] = { "<cmd>noa w<cr>", desc = "Write File" },

		-- Menu
		["<leader>m"] = { "<cmd>Mason<cr>", desc = "Open Mason" },
		["<leader>a"] = { "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },

		-- Macros
		["m"] = { "q" },
		[","] = { "Q" },

		-- Git
		["<leader>gh"] = { "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
		["<leader>gb"] = { "<cmd>Gitsigns blame_line<cr>", desc = "Blame" },
		["<leader>gr"] = { "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },

		-- Extra Functions
		["<leader>gg"] = {
			function()
				toggle_term_cmd("lazygit -ucd ~/.config/lazygit")
			end,
			desc = "Lazygit",
		},
		["<CR>"] = {
			function()
				if vim.bo.filetype == "man" or vim.bo.filetype == "help" then
					vim.cmd('execute "tag " . expand("<cword>")')
				else
					vim.cmd('Telescope lsp_definitions')
				end
			end
		}
	},

	-- Visual
	v = {
		-- Remove Mapping
		["<leader>/"] = false,

		-- Navigation
		["w"]     = { "b" },
		["W"]     = { "B" },
		["<S-h>"] = { "^" },
		["<S-l>"] = { "$" },
		["J"]     = { "Lzz" },
		["K"]     = { "Hzz" },

		-- Copy
		["x"] = { "y", desc = "Copy", remap = true },
		["X"] = { '"+x', desc = "Copy", remap = true },

		-- Comment
		["#"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" },

		-- Macros
		[","] = { ":'<,'>normal! Q<cr>" }
	},

	-- Terminal
	t = {
		-- setting a mapping to false will disable it
		-- ["<esc>"] = false,
	},
}
