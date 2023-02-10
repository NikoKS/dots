return {
  n = {
    ["]d"] = false,
    ["[d"] = false,
    ["K"] = false,
    ["gl"] = false,
    ["gT"] = false,
    ["<leader>la"] = false,
    ["<leader>ld"] = false,
    ["<leader>lf"] = false,
    ["<leader>lh"] = false,
    ["<leader>ll"] = false,
    ["<leader>lL"] = false,
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Get Refrences" },
    ["<leader>lR"] = { "<cmd>LspRestart<cr>", desc = "Restart LSP" },
    ["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename symbol" },
  }
}
