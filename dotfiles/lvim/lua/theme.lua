-- Additional settings for colorscheme
lvim.transparent_window = true
lvim.colorscheme = "nordfox"
local nightfox = require("nightfox")
local colors = require("nightfox.colors.nordfox").load()
nightfox.setup({
	fox = "nordfox", -- change the colorscheme to use nordfox
	styles = {
		-- comments = "italic", -- change style of comments to be italic
		transprent = true,
		keywords = "bold", -- change style of keywords to be bold
		functions = "italic", -- styles can be a comma separated list
	},
	inverse = {
		match_paren = true, -- inverse the highlighting of match_parens
	},
	hlgroups = {
		-- Sneak
		Sneak = { bg = colors.none, fg = colors.yellow },
		SneakLabel = { bg = colors.none, fg = colors.yellow },
		SneakScope = { fg = colors.white, style = "reverse" },
		-- NvimTree
		NvimTreeEndOfBuffer = { fg = colors.fg },
		NvimTreeRootFolder = { fg = colors.fg, style = colors.none },
		NvimTreeGitDirty = { fg = colors.yellow },
		NvimTreeGitNew = { fg = colors.green },
		-- GitSigns
		GitSignsAdd = { fg = colors.green },
		GitSignsChange = { fg = colors.yellow },
		-- General
		VertSplit = { fg = colors.bg_alt, style = colors.none },
		NormalFloat = { bg = colors.none },
		IndentBlanklineContextChar = { fg = colors.blue },
		MatchParen = { bg = colors.black, fg = colors.none },
		Folded = { bg = colors.none, fg = colors.comment },
	},
})

-- bufferline
lvim.builtin.bufferline.options.separator_style = "thick"
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.highlights = {
	fill = { guibg = colors.bg_alt },
	background = { guibg = colors.bg_alt },
	close_button = { guibg = colors.bg_alt },
	diagnostic = { guibg = colors.bg_alt },
	error = { guibg = colors.bg_alt },
	error_selected = { guifg = colors.white },
	error_diagnostic = { guibg = colors.bg_alt, guifg = colors.red },
	error_diagnostic_visible = { guifg = colors.red },
	modified = { guibg = colors.bg_alt, guifg = colors.yellow },
	modified_selected = { guifg = colors.yellow },
	modified_visible = { guifg = colors.yellow },
	separator = { guifg = colors.fg_gutter },
}

nightfox.load()
-- ⃒⎥⎟⎜┃▏▎▍

-- better whitespace
vim.g["better_whitespace_guicolor"] = colors.red
