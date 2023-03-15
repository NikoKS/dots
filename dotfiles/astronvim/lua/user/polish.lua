return function()
  -- Diagnostic Float
  vim.api.nvim_create_autocmd("CursorHold", {
    pattern = { "*" },
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
    end
  })
end
