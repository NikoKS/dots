local colors = require('nightfox.colors.nordfox').load()

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end


-- lvim.builtin.lualine.sections.lualine_a = { nil }
-- lvim.builtin.lualine.sections.lualine_b = { nil }

lvim.builtin.lualine.sections.lualine_c = {
  {
    "diff",
    source = diff_source,
    symbols = { added = "  ", modified = "柳", removed = " " },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    -- color = { bg = 'default' },
    color = {},
    cond = nil,
  }
}
