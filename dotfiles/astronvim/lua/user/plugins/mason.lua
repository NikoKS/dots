-- customize mason plugins
return {
	-- use mason-lspconfig to configure LSP installations
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, config)
			local null_ls = require("null-ls")
			config.sources = {
				-- null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
				-- null_ls.builtins.diagnostics.pydocstyle.with({ extra_args = { "--convention", "google" } }),
				null_ls.builtins.formatting.prettierd.with({ extra_filetypes = { "svelte", "astro", "xml" } }),
			}
			return config -- return final config table
		end,
	},
}
