return {
  format_on_save = {
    -- enabled = false, -- enable format on save
    ignore_filetypes = { "python" }
  },
  filter = function(client)
    -- disable formatting for sumneko_lua
    -- if client.name == "sumneko_lua" then
    --   return false
    -- end

    -- only enable null-ls for svelte and astro files
    if vim.bo.filetype == "svelte" or vim.bo.filetype == "astro" then
      return client.name == "null-ls"
    end

    -- enable all other clients
    return true
  end
}
