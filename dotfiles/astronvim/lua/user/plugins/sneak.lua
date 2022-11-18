vim.g["sneak#label"] = 1
vim.g["sneak#use_ic_scs"] = 1
vim.g["sneak#prompt"] = ''
vim.g["sneak#target_labels"] = 'fjewo;dkslqpurvncmzxbtySDFGHJKLZXCVBNMQWERTYUOP,./<>?:"[]{}|1234567890-=!@#$%^&*()_+`~'

vim.keymap.set('n', 'f', ":<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>")
vim.keymap.set('n', 'F', ":<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>")
vim.keymap.set('v', 'f', ":<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>")
vim.keymap.set('v', 'F', ":<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>")
vim.keymap.set('o', 'f', ":<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>")
vim.keymap.set('o', 'F', ":<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>")
