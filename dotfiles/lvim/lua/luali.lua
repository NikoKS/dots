local colors = require("nightfox.palette").load('nordfox')

lvim.builtin.lualine.options.theme = {
	normal = {
		a = { fg = colors.fg0, bg = colors.bg0 },
		b = { fg = colors.fg0, bg = colors.bg0 },
		c = { fg = colors.fg0, bg = colors.bg0 },
	},
}
