-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "github_dark_default",
    folding = {
      methods = { "treesitter", "indent" },
    },
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
          -- Transparent
          Normal = { bg = "none" },
          NormalNC = { bg = "none" },
          WinBar = { bg = "none" },
          WinBarNC = { bg = "none" },
        }
        return highlights
      end,
    },
  },
}
