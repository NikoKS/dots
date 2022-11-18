vim.o.fillchars = "vert: ,eob: ,fold: ,foldopen: "

local colors = require("nightfox.palette").load('nordfox')
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg=colors.bg0 })
-- vim.highlight.create('NvimTreeVertSplit', {guifg=colors.black}, false)

-- ⃒⎥⎟⎜┃▏▎▍
