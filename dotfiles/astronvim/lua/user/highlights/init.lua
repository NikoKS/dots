return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  -- get highlights from highlight groups
  local normal = get_hlgroup "Normal"
  local fg, bg = normal.fg, normal.bg
  local bg_alt = get_hlgroup("StatusLine").bg
  local green = get_hlgroup("String").fg
  local red = get_hlgroup("Error").fg
  -- return a table of highlights for telescope based on colors gotten from highlight groups
  return {
    NeoTreeRootName = { fg = fg },
    NeoTreeWinSeparator = { bg = bg_alt, fg = bg_alt },
  }
end
