return {
  -- control auto formatting on save
  format_on_save = {
    enabled = true,      -- enable or disable format on save globally
    ignore_filetypes = { -- disable format on save for specified filetypes
      "python",
    },
  },
  filter = function(client) -- fully override the default formatting function
    if vim.bo.filetype == "svelte" or vim.bo.filetype == "astro" then
      return client.name == "null-ls"
    end
    return true
  end
}
