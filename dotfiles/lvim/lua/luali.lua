local colors = require("nightfox.colors.nordfox").load()

vim.g["tpipeline_preservebg"] = 1
vim.g["tpipeline_clearstl"] = 1

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

lvim.builtin.lualine.options.theme = {
	inactive = {
		a = { fg = colors.active, bg = colors.none, gui = "bold" },
		b = { fg = colors.active, bg = colors.none },
		c = { fg = colors.active, bg = colors.none },
	},
	visual = {
		a = { fg = colors.active, bg = colors.none, gui = "bold" },
		b = { fg = colors.active, bg = colors.none },
		c = { fg = colors.active, bg = colors.none },
	},
	replace = {
		a = { fg = colors.active, bg = colors.none, gui = "bold" },
		b = { fg = colors.active, bg = colors.none },
		c = { fg = colors.active, bg = colors.none },
	},
	normal = {
		a = { fg = colors.active, bg = colors.none, gui = "bold" },
		b = { fg = colors.active, bg = colors.none },
		c = { fg = colors.active, bg = colors.none },
	},
	insert = {
		a = { fg = colors.active, bg = colors.none, gui = "bold" },
		b = { fg = colors.active, bg = colors.none },
		c = { fg = colors.active, bg = colors.none },
	},
	command = {
		a = { fg = colors.active, bg = colors.none, gui = "bold" },
		b = { fg = colors.active, bg = colors.none },
		c = { fg = colors.active, bg = colors.none },
	},
}

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = { nil }

lvim.builtin.lualine.sections.lualine_b = {
	components.branch,
	{ "filename", path = 1 },
}

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
		-- color = { bg = 'default', fg = nil },
		color = {},
		cond = nil,
	},
}

lvim.builtin.lualine.sections.lualine_z = { "location" }
