-- Remove ][ mapping
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "python,sql",
  callback = function()
    vim.cmd("silent! nunmap <buffer> [[")
    vim.cmd("silent! nunmap <buffer> []")
    vim.cmd("silent! nunmap <buffer> [{")
    vim.cmd("silent! nunmap <buffer> [M")
    vim.cmd("silent! nunmap <buffer> [m")
    vim.cmd('silent! nunmap <buffer> ["')

    vim.cmd("silent! nunmap <buffer> ][")
    vim.cmd("silent! nunmap <buffer> ]]")
    vim.cmd("silent! nunmap <buffer> ]}")
    vim.cmd("silent! nunmap <buffer> ]M")
    vim.cmd("silent! nunmap <buffer> ]m")
    vim.cmd('silent! nunmap <buffer> ]"')
  end
})


-- Python ftplugin
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "python",
  callback = function()
    local map = {
      ['<leader>rf'] = { '<cmd>SlimeSend0 "python3 " . expand("%:p") . "\\n"<cr>', "Run File" },
      ['<leader>rp'] = { '<cmd>SlimeSend1 python3<cr>', "Run Python" },
      ['<leader>re'] = { '<cmd>SlimeSend1 exit()<cr>', "Exit Python" },
    }
    require('which-key').register(map)
  end
})

-- JS ftplugin
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "javascript",
  callback = function()
    local map = {
      ['<leader>rf'] = { '<cmd>SlimeSend0 "node " . expand("%:p") . "\\n"<cr>', "Run File" },
      ['<leader>rp'] = { '<cmd>SlimeSend1 node<cr>', "Run node" },
      ['<leader>re'] = { '<cmd>SlimeSend1 .exit<cr>', "Exit node" }
    }
    require('which-key').register(map)
  end
})

-- Golang ftplugin
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "go",
  callback = function()
    local map = {
      ['<leader>rf'] = { '<cmd>SlimeSend0 "go run " . expand("%:p") . "\\n"<cr>', "Run File" },
    }
    require('which-key').register(map)
  end
})

-- Markdown ftplugin
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "markdown",
  callback = function()
    vim.wo.wrap = 1
  end
})

-- Rust ftplugin
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "rust",
  callback = function()
    local map = {
      ['<leader>rb'] = { '<cmd>SlimeSend1 cargo build<cr>', "Build Project" },
      ['<leader>rr'] = { '<cmd>SlimeSend1 cargo run<cr>', "Run Project" },
      ['<leader>rd'] = { '<cmd>cargo doc --open<cr>', "Get Documentation" },
    }
    require('which-key').register(map)
  end
})

-- Autosource
vim.api.nvim_create_autocmd({ "VimEnter", "TermLeave" }, {
  pattern = "*",
  callback = function()
    vim.cmd('AutoSource')
  end
})

-- Diagnostic Float
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = { "*" },
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
  end
})

-- Cursorline
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = { "*" },
  callback = function()
    if vim.g.indent_blankline_enabled and
        not vim.tbl_contains(vim.g.indent_blankline_filetype_exclude, vim.bo.filetype) and
        not vim.tbl_contains(vim.g.indent_blankline_buftype_exclude, vim.bo.buftype) then
      vim.wo.cursorline = true -- Cursor line only on active window
      vim.cmd('IndentBlanklineEnable')
      vim.diagnostic.show(nil, 0)
    end
  end
})
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = { "*" },
  callback = function()
    if vim.g.indent_blankline_enabled and
        not vim.tbl_contains(vim.g.indent_blankline_filetype_exclude, vim.bo.filetype) and
        not vim.tbl_contains(vim.g.indent_blankline_buftype_exclude, vim.bo.buftype) then
      vim.wo.cursorline = false
      vim.cmd('IndentBlanklineDisable')
      vim.diagnostic.hide(nil, 0)
    end
  end
})
