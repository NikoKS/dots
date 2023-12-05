return function()
	local get_hlgroup = require("astronvim.utils").get_hlgroup
	-- get highlights from highlight groups
	local bg_alt = get_hlgroup("TabLineFill").bg
	-- return a table of highlights for telescope based on colors gotten from highlight groups
	return {
		-- NeoTree
		NeoTreeWinSeparator = { bg = bg_alt, fg = bg_alt },
		NeoTreeNormal = { bg = bg_alt },
		-- StatusLine
		StatusLine = { bg = bg_alt },
	}
end
