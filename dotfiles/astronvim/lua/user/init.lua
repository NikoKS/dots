return {
  colorscheme = "nordfox",
  options = {
    opt = {
      relativenumber = false, -- sets vim.opt.relativenumber
      fillchars = "vert: ,eob: ,fold: ,foldopen: ",
      clipboard = ""
    },
    g = {
      mapleader = ";", -- sets vim.g.mapleader
    }
  },
  diagnostics = {
    virtual_text = false,
    underline = { severity = { min = vim.diagnostic.severity.HINT } },
  },
}