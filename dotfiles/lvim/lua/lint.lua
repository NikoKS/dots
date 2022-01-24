-- linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    exe = "flake8",
    filetypes = { "python" }
  },
  {
    exe = "mypy",
    filetypes = { "python" }
  }
}
