-- line, bar, tree
local tree_cb = require("nvim-tree.config").nvim_tree_callback

lvim.builtin.nvimtree.setup = {
  disable_netrw = true,
  open_on_setup = true,
  update_cwd = true,
  hijack_cursor = true,
  -- update_focused_file = {
    -- enable = true,
    -- update_cwd = true
  -- },
  view = {
    mappings = {
      list = {
        { key = { "<space>" }, cb = tree_cb("edit") },
        { key = { "<esc>" }, cb = tree_cb("close") },
        { key = { "x" }, cb = tree_cb("copy")}
      }
    }
  },
  renderer = {
    add_trailing = true
  },
}
