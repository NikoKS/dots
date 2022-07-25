vim.o.fillchars = "vert:▍,eob: ,fold: ,foldopen: "

local colors = require("nightfox.palette").load('nordfox')
vim.highlight.create('NvimTreeNormal', { guibg=colors.bg0 }, false)
-- vim.highlight.create('NvimTreeVertSplit', {guifg=colors.black}, false)

-- ⃒⎥⎟⎜┃▏▎▍
