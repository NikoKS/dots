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

-- format on save
lvim.format_on_save = true

-- lsp
lvim.lsp.diagnostics.virtual_text = false

-- Change lsp info window border
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end

