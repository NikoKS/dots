return {
  colorscheme = "nordfox",
  options = function(local_vim)
    local_vim.opt.relativenumber = false
    local_vim.opt.fillchars = "vert: ,eob: ,fold: ,foldopen: "
    local_vim.opt.clipboard = ""
    local_vim.opt.iskeyword = vim.opt.iskeyword + { '-' }

    local_vim.g.mapleader = ";"
    return local_vim
  end,
  diagnostics = {
    virtual_text = false,
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
  },
}
