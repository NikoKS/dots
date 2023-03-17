local actions = require("telescope.actions")

return {
	-- customize alpha options
	{
		"goolord/alpha-nvim",
		opts = function(_, opts)
			-- customize the dashboard header
			opts.section.header.val = {
				"    ███    ██ ██    ██ ██ ███    ███",
				"    ████   ██ ██    ██ ██ ████  ████",
				"    ██ ██  ██ ██    ██ ██ ██ ████ ██",
				"    ██  ██ ██  ██  ██  ██ ██  ██  ██",
				"    ██   ████   ████   ██ ██      ██",
			}
			return opts
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			window = {
				mappings = {
					["<space>"] = "toggle_node",
				},
			},
			filesystem = {
				bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
			},
		},
	},
	{
		"stevearc/aerial.nvim",
		opts = {
			keymaps = {
				[" "] = "actions.tree_toggle",
				["M"] = "actions.scroll",
			},
			manage_folds = true,
			link_folds_to_tree = false,
			link_tree_to_folds = false,
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				mappings = {
					i = {
						["<Tab>"] = actions.move_selection_next,
						["<S-Tab>"] = actions.move_selection_previous,
					},
					n = {
						["<Tab>"] = actions.move_selection_next,
						["<S-Tab>"] = actions.move_selection_previous,
						["<S-j>"] = actions.preview_scrolling_down,
						["<S-k>"] = actions.preview_scrolling_up,
						["<space>"] = actions.toggle_selection,
						["w"] = function()
							vim.cmd([[execute "normal! b"]])
						end,
						["W"] = function()
							vim.cmd([[execute "normal! B"]])
						end,
					},
				},
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		opts = {
			history = false,
			region_check_events = "InsertEnter",
		},
	},
}
