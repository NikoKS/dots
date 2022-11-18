-- Python ftplugin
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "python",
  callback = function()
    vim.keymap.del('n', ']M' ,{ buffer = 0 })
    vim.keymap.del('n', ']m' ,{ buffer = 0 })
    vim.keymap.del('n', '][' ,{ buffer = 0 })
    vim.keymap.del('n', ']]' ,{ buffer = 0 })
    vim.keymap.del('n', '[M' ,{ buffer = 0 })
    vim.keymap.del('n', '[m' ,{ buffer = 0 })
    vim.keymap.del('n', '[[' ,{ buffer = 0 })
    vim.keymap.del('n', '[]' ,{ buffer = 0 })
  end
})
