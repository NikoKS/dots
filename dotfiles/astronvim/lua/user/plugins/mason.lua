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
		"williamboman/mason-lspconfig.nvim",
		-- overrides `require("mason-lspconfig").setup(...)`
		opts = {
			-- ensure_installed = { "lua_ls" },
		},
	},
	-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
	{
		"jay-babu/mason-null-ls.nvim",
		-- overrides `require("mason-null-ls").setup(...)`
		opts = {
			-- ensure_installed = { "prettier", "stylua" },
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		-- overrides `require("mason-nvim-dap").setup(...)`
		opts = {
			-- ensure_installed = { "python" },
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, config)
			local null_ls = require("null-ls")
			config.sources = {
				-- null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
				-- null_ls.builtins.diagnostics.pydocstyle.with({ extra_args = { "--convention", "google" } }),
				null_ls.builtins.formatting.prettier.with({ extra_filetypes = { "svelte", "astro" } }),
			}
			return config -- return final config table
		end,
	},
}
