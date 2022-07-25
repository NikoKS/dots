-- All settings related to theme and color

local nightfox = require('nightfox')
local colors = require("nightfox.palette").load('nordfox')
lvim.transparent_window = true
require('nightfox').setup({
  options = {
    styles = {              -- Style to be applied to different syntax groups
      -- comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
      -- conditionals = "NONE",
      -- constants = "NONE",
      -- functions = "italic",
      keywords = "bold",
      -- numbers = "NONE",
      -- operators = "NONE",
      -- strings = "NONE",
      -- types = "NONE",
      -- variables = "NONE",
    },
    -- inverse = {             -- Inverse highlight for different types
      -- match_paren = true,
      -- visual = false,
      -- search = false,
    -- },
    -- modules = true             -- List of various plugins and additional options
  },
  groups = {
    nordfox = {
      -- Sneak
      Sneak = { bg = "none", fg = colors.yellow.base },
      SneakLabel = { bg = "none", fg = colors.yellow.base },
      SneakScope = { fg = colors.white.base, style = "reverse" },
      -- -- NvimTree
      -- NvimTreeEndOfBuffer = { fg = colors.fg.base },
      NvimTreeRootFolder = { fg = colors.fg1, style = nil },
      -- NvimTreeGitDirty = { fg = colors.yellow.base },
      -- NvimTreeGitNew = { fg = colors.green.base },
      -- -- GitSigns
      -- GitSignsAdd = { fg = colors.green.base },
      -- GitSignsChange = { fg = colors.yellow.base },
      -- -- General
      VertSplit = { fg = colors.bg3, style = nil },
      NormalFloat = { bg = "none" },
      IndentBlanklineContextChar = { fg = colors.blue.dim },
      -- MatchParen = { bg = colors.black.base, fg = "none" },
      -- Folded = { bg = "none", fg = colors.comment.base },
    }
  }
})

nightfox.compile()
lvim.colorscheme = "nordfox"

-- bufferline
-- lvim.builtin.bufferline.options.separator_style = "thick"
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.highlights = {
	fill = { guibg = colors.bg0 },
	background = { guibg = colors.bg0 },
	close_button = { guibg = colors.bg0 },
	diagnostic = { guibg = colors.bg0 },
	duplicate = { guibg = colors.bg0 },
	separator = { guibg = colors.bg0 },
	error = { guibg = colors.bg0 },
	error_selected = { guifg = colors.fg1 },
	error_diagnostic = { guibg = colors.bg0, guifg = colors.red.base },
	error_diagnostic_selected = { guifg = colors.red.base },
	error_diagnostic_visible = { guifg = colors.red.base },
	warning = { guibg = colors.bg0 , guifg = colors.fg1},
	warning_selected = { guifg = colors.fg1},
	warning_diagnostic = { guibg = colors.bg0, guifg = colors.yellow.base },
	warning_diagnostic_selected = { guifg = colors.yellow.base },
	warning_diagnostic_visible = { guifg = colors.yellow.base },
	modified = { guibg = colors.bg0, guifg = colors.yellow.base },
	modified_selected = { guifg = colors.yellow.base },
	modified_visible = { guifg = colors.yellow.base },
}

-- nightfox.load()

-- better whitespace
vim.g["better_whitespace_guicolor"] = colors.red.base
