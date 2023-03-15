local utils = require('astronvim.utils')
return {
  -- first key is the mode
  n = {
    -- Remove Mapping
    ["<leader>/"]  = false,
    ["q"]          = "<nop>",     -- <nop> for vim defaults
    -- General
    ["r"]          = { "<C-r>" }, -- Redo
    ["R"]          = { "<cmd>e!<CR>" },
    ["#"]          = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>" },
    [" "]          = { "za" },
    ["<leader>a"]  = { "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },
    -- Quit
    ["qq"]         = { ":q<cr>" },
    ["qw"]         = { "ZZ" },
    ["qa"]         = { ":qa<CR>" },
    ["qe"]         = { ":q!<CR>" },
    ["qf"]         = { "<cmd>Bdelete<cr>" },
    -- Navigation
    ["w"]          = { "b" },
    ["W"]          = { "B" },
    ["<S-h>"]      = { "^" },
    ["<S-l>"]      = { "$" },
    ["J"]          = { "<C-d>", remap = true },
    ["K"]          = { "<C-u>", remap = true },
    ["}"]          = { "]b", remap = true },
    ["{"]          = { "[b", remap = true },
    ["<C-f>"]      = { "<leader>ff", remap = true },
    -- Copy, Delete
    ["x"]          = { "y", desc = "Copy", remap = true },
    ["X"]          = { '"+x', desc = "Copy to system", remap = true },
    ["yx"]         = { "yy", desc = "Copy current line" },
    ["yp"]         = { '"0p', desc = "paste from copy buffer" },
    ["yP"]         = { '"0P', desc = "Paste from copy buffer" },
    ["yf"]         = { 'ggVG"+y', desc = "Copy entire file" },
    -- Extra Functions
    ["<leader>gg"] = {
      function()
        utils.toggle_term_cmd("lazygit -ucd ~/.config/lazygit")
      end,
      desc = "Lazygit",
    },
    ["<leader>ld"] = {
      function()
        utils.toggle_term_cmd("lazydocker")
      end,
      desc = "LazyDocker",
    },
    ["<CR>"]       = {
      function()
        if vim.bo.filetype == "man" or vim.bo.filetype == "help" then
          vim.cmd('execute "tag " . expand("<cword>")')
        else
          vim.cmd('Telescope lsp_definitions')
        end
      end
    }
  },
  v = {
    -- Remove Mapping
    ["<leader>/"] = false,
    -- Navigation
    ["w"]         = { "b" },
    ["W"]         = { "B" },
    ["<S-h>"]     = { "^" },
    ["<S-l>"]     = { "$" },
    ["J"]         = { "Lzz" },
    ["K"]         = { "Hzz" },
    -- Copy
    ["x"]         = { "y", desc = "Copy", remap = true },
    ["X"]         = { '"+x', desc = "Copy", remap = true },
    -- Comment
    ["#"]         = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" },
  },
}
