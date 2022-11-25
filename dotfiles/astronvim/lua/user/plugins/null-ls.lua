local null_ls = require("null-ls")

return {
  sources = {
    null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
    null_ls.builtins.diagnostics.pydocstyle.with({ extra_args = { "--convention", "google" } })
  }
}
