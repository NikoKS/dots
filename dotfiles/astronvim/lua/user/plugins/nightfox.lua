local colors = require("nightfox.palette").load('nordfox')

require('nightfox').setup({
  options = {
    styles = { -- Style to be applied to different syntax groups
      keywords = "bold,italic",
      comments = "italic",
    },
  },
  groups = {
    nordfox = {
      -- Sneak
      Sneak = { bg = "none", fg = colors.yellow.base },
      SneakLabel = { bg = "none", fg = colors.yellow.base },
      SneakScope = { fg = colors.white.base, style = "reverse" },
      -- General
      VertSplit = { fg = colors.bg0, bg = colors.bg0, style = nil },
      NormalFloat = { bg = "none" },
      IndentBlanklineContextChar = { fg = colors.blue.dim },
      -- Neo-Tree
      NeoTreeRootName = { fg = colors.white.base },
      NeoTreeTabActive = { bg = colors.bg0 },
      NeoTreeTabInactive = { bg = colors.bg1 },
      NeoTreeTabSeparatorActive = { bg = colors.bg0 },
      NeoTreeTabSeparatorInactive = { bg = colors.bg1 },
      -- Bufferline
      BufferLineFill = { bg = colors.bg0 }
    }
  }
})
