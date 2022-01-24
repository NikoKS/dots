-- Additional settings for colorscheme
lvim.transparent_window = true
lvim.colorscheme = "nordfox"
local nightfox = require('nightfox')
local colors = require('nightfox.colors.nordfox').load()
nightfox.setup({
  fox = "nordfox", -- change the colorscheme to use nordfox
  styles = {
    -- comments = "italic", -- change style of comments to be italic
    transprent = true,
    keywords = "bold", -- change style of keywords to be bold
    functions = "italic" -- styles can be a comma separated list
  },
  inverse = {
    match_paren = true, -- inverse the highlighting of match_parens
  },
  hlgroups = {
    -- Sneak
    Sneak = { bg = colors.none, fg = colors.yellow },
    SneakLabel = { bg = colors.none, fg = colors.yellow },
    SneakScope = { fg = colors.white, style = 'reverse'},
    -- NvimTree
    NvimTreeEndOfBuffer = { fg = colors.fg },
    NvimTreeRootFolder = { fg = colors.fg , style = colors.none},
    NvimTreeGitDirty = { fg = colors.yellow },
    NvimTreeGitNew = { fg = colors.green },
    -- BarBar
    BufferOffset = { bg = colors.fg_gutter },
    -- BufferCurrent = { bg = colors.none },
    -- BufferCurrentMod = { bg = colors.none },
    -- BufferCurrentSign = { fg = colors.green },
    -- BufferVisible = { bg = colors.active },
    -- BufferVisibleSign = { bg = colors.active, fg = colors.green },
    -- BufferVisibleMod = { bg = colors.active, fg = colors.yellow },
    --GitSigns
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.yellow },
    --
    VertSplit = { fg = colors.fg_gutter, style = 'bold' }
  }
})

nightfox.load()
