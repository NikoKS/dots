-- linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "flake8",
		filetypes = { "python" },
		args = { "--max-line-length", "88" },
	},
	{
		exe = "mypy",
		filetypes = { "python" },
	},
})

-- formatter
lvim.format_on_save = false
local formatter = require("lvim.lsp.null-ls.formatters")
formatter.setup({
	{
		exe = "black",
		extra_args = { "--fast" },
		filetypes = { "python" },
	},
	{
		exe = "isort",
		filetypes = { "python" },
	},
	{
		command = "stylua",
		filetypes = { "lua" },
	},
	{
		exe = "eslint",
		filetype = { "javascript" },
	},
  {
    exe = "rustfmt",
    filetype = { "rust" },
  }
})

-- lsp
lvim.lsp.diagnostics.virtual_text = false
-- require("lvim.lsp.manager").setup("tsserver")
-- require("lvim.lsp.manager").setup("denols")

-- Change lsp info window border
local win = require("lspconfig.ui.windows")
local _default_opts = win.default_opts
win.default_opts = function(options)
	local opts = _default_opts(options)
	opts.border = "rounded"
	return opts
end
