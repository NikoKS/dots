vim.o.fillchars = "vert:▍,eob: ,fold: ,foldopen: "

local colors = require('nightfox.colors.nordfox').load()
vim.highlight.create('NvimTreeNormal', {guibg=colors.bg_alt}, false)
vim.highlight.create('NvimTreeVertSplit', {guifg=colors.black}, false)
