return {
	-- Set colorscheme to use
	colorscheme = "github_dark_default",
	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		virtual_text = false,
		underline = true,
	},
	-- Configure require("lazy").setup() options
	lazy = {
		defaults = { lazy = true },
		performance = {
			rtp = {
				-- customize default disabled vim plugins
				disabled_plugins = {
					"tohtml",
					"gzip",
					"matchit",
					"zipPlugin",
					"netrwPlugin",
					"tarPlugin",
					"matchparen",
				},
			},
		},
		ui = {
			border = "rounded",
		},
	},
}
