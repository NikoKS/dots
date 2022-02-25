vim.cmd("unmap <buffer> [[")
vim.cmd("unmap <buffer> []")
vim.cmd("unmap <buffer> [M")
vim.cmd("unmap <buffer> [m")
vim.cmd("unmap <buffer> ][")
vim.cmd("unmap <buffer> ]M")
vim.cmd("unmap <buffer> ]]")
vim.cmd("unmap <buffer> ]m")

vim.cmd([[
  nmap <leader>rf :SlimeSend0 "python3 " . expand('%:p') . "\n"<cr>
]])
lvim.builtin.which_key.mappings["rf"] = "Run Python File"
lvim.builtin.which_key.mappings["rr"] = { ":SlimeSend1 python3 <cr>", "Run Python REPL" }
lvim.builtin.which_key.mappings["re"] = { ":SlimeSend1 exit() <cr>", "Exit REPL" }
