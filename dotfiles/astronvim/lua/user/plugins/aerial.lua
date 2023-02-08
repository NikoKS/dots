return {
  on_attach = function(bufnr) end,
  keymaps = {
    [" "] = "actions.tree_toggle",
    -- ["j"] = "actions.down_and_scroll",
    -- ["k"] = "actions.up_and_scroll",
    ["M"] = "actions.scroll",
  },
  highlight_on_jump = 200,
  highlight_on_hover = true,
}
