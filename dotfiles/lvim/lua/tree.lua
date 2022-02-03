-- line, bar, tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_cursor = true
lvim.builtin.nvimtree.setup.update_cwd = true
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = true
lvim.builtin.nvimtree.setup.diagnostics.enable = false
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
lvim.builtin.nvimtree.setup.view.mappings.list = {
  { key = {"<space>"}, cb = tree_cb("edit") },
  { key = {"<esc>"}, cb = tree_cb("close") },
}
