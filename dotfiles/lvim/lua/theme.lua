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
      functions = "italic",
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
      VertSplit = { fg = colors.bg0, bg=colors.bg0, style = nil },
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
	fill = { bg = colors.bg0 },
	background = { bg = colors.bg0 },
	close_button = { bg = colors.bg0 },
	diagnostic = { bg = colors.bg0 },
	duplicate = { bg = colors.bg0 },
	separator = { bg = colors.bg0, fg = colors.bg1 },
	separator_selected = { bg = colors.bg0, fg = colors.bg1 },
	hint = { bg = colors.bg0 },
	hint_visible = { fg = colors.fg1 },
	hint_selected = { fg = colors.fg1 },
	info = { bg = colors.bg0 },
	info_diagnostic = { bg = colors.bg0 },
	info_visible = { fg = colors.fg1 },
	info_selected = { fg = colors.fg1 },
	error = { bg = colors.bg0 },
	error_selected = { fg = colors.fg1 },
	error_diagnostic = { bg = colors.bg0, fg = colors.red.base },
	error_diagnostic_selected = { fg = colors.red.base },
	error_diagnostic_visible = { fg = colors.red.base },
	warning = { bg = colors.bg0 },
	warning_selected = { fg = colors.fg1},
	warning_diagnostic = { bg = colors.bg0, fg = colors.yellow.base },
	warning_diagnostic_selected = { fg = colors.yellow.base },
	warning_diagnostic_visible = { fg = colors.yellow.base },
	modified = { bg = colors.bg0, fg = colors.yellow.base },
	modified_selected = { fg = colors.yellow.base },
	modified_visible = { fg = colors.yellow.base },
}

-- nightfox.load()

-- better whitespace
vim.g["better_whitespace_guicolor"] = colors.red.base
