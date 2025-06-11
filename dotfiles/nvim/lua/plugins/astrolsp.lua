---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {
          "python",
        },
      },
    },
    mappings = {
      n = {
        ["K"] = false,
        -- ["<leader>lD"] = false,
        -- ["<leader>ld"] = false,
        -- ["<leader>ls"] = false,
        -- ["<leader>lR"] = { "<cmd>LspRestart<cr>", desc = "Restart Lsp" },
        -- Telescope
        ["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search symbols" },
        ["<leader>ff"] = { "<cmd>Telescope resume<cr>", desc = "Resume last search" },
        ["<leader>fd"] = { "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostic" },
      },
    },
    -- config = {
    --   yamlls = {
    --     settings = {
    --       yaml = {
    --         schemas = {
    --           ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
    --           ["../path/relative/to/file.yml"] = "/.github/workflows/*",
    --           ["/path/from/root/of/project"] = "/.github/workflows/*",
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}
