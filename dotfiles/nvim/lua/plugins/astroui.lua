---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "github_dark_default",
    highlights = {
      init = function()
        local get_hlgroup = require("astroui").get_hlgroup
        local bg_alt = get_hlgroup("TabLineFill").bg

        -- Global Highlights --
        local highlights = {
          -- NeoTree
          NeoTreeWinSeparator = { bg = bg_alt, fg = bg_alt },
          NeoTreeNormal = { bg = bg_alt },
          -- StatusLine
          StatusLine = { bg = bg_alt },
        }
        return highlights
      end,
    },
  },
}
