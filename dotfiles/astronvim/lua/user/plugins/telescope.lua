local actions = require("telescope.actions")

return {
  defaults = {
    mappings = {
      i = {
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
      },
      n = {
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<S-j>"] = actions.preview_scrolling_down,
        ["<S-k>"] = actions.preview_scrolling_up,
        ["<space>"] = actions.toggle_selection,
        ["w"] = function()
          vim.cmd([[execute "normal! b"]])
        end,
        ["W"] = function()
          vim.cmd([[execute "normal! B"]])
        end,
      },
    }
  }
}
