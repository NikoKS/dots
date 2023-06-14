return {
	n = {
		["K"] = false,
		["<leader>lD"] = false,
		["<leader>ld"] = false,
		["<leader>ls"] = false,
		["<leader>lR"] = { "<cmd>LspRestart<cr>", desc = "Restart Lsp" },
		["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search symbols" },
	},
}
