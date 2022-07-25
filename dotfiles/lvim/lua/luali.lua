local colors = require("nightfox.palette").load('nordfox')

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
	normal = {
		a = { fg = colors.fg0, bg = colors.bg0, gui = "bold" },
		b = { fg = colors.fg0, bg = colors.bg0 },
		c = { fg = colors.fg0, bg = colors.bg0 },
	},
}

lvim.builtin.lualine.sections.lualine_c = {
	{
		"diff",
		source = diff_source,
		symbols = { added = "  ", modified = "柳", removed = " " },
		diff_color = {
			added = { fg = colors.green.base },
			modified = { fg = colors.yellow.base },
			removed = { fg = colors.red.base },
		},
		-- color = { bg = 'default', fg = nil },
		color = {},
		cond = nil,
	},
}

lvim.builtin.lualine.sections.lualine_z = { "location" }
