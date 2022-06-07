vim.cmd("unmap <buffer> [[")
vim.cmd("unmap <buffer> []")
vim.cmd("unmap <buffer> [M")
vim.cmd("unmap <buffer> [m")
vim.cmd("unmap <buffer> ][")
vim.cmd("unmap <buffer> ]M")
vim.cmd("unmap <buffer> ]]")
vim.cmd("unmap <buffer> ]m")
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'

vim.treesitter.set_query("python", "folds", [[
  (function_definition (block) @fold)
  (class_definition (block) @fold)
]])

lvim.lsp.buffer_mappings.normal_mode["gi"] = { ":Telescope grep_string<CR>", "Grep String" }

local wk = require("which-key")
vim.cmd([[
  nmap <buffer> <leader>rf :SlimeSend0 "python3 " . expand('%:p') . "\n"<cr>
  nmap <buffer> <leader>rr :SlimeSend1 python3 <cr>
  nmap <buffer> <leader>re :SlimeSend1 exit() <cr>
]])
wk.register({
   f = "Run Python File",
   r = "Run Python REPL",
   e = "Exit REPL"
}, { prefix = ";r", buffer = 0 })
