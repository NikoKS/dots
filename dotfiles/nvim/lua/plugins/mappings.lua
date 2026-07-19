-- AstroCore mappings are configured separately to keep the core settings focused.
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- first key is the mode
      n = {
        -- Disable default mappings
        ["<Leader>/"] = false,
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<Leader>h"] = false,
        ["<Leader>q"] = false,
        ["<Leader>Q"] = false,
        ["<Leader>o"] = false,
        ["q"] = "<nop>", -- <nop> for vim defaults
        -- General/Utility
        ["r"] = { "<C-r>" }, -- Redo
        ["R"] = { "<cmd>e!<CR>", desc = "Refresh file" },
        ["#"] = { "<cmd>normal gcc<cr>" },
        [" "] = { "za" },
        ["?"] = { "<cmd>lua vim.lsp.buf.hover()<cr>" },
        ["="] = { "<c-w>=" },
        ["<C-f>"] = {
          function() require("snacks").picker.files() end,
          desc = "Find File",
        },
        -- Quit
        ["qq"] = { ":q<cr>", silent = true },
        ["qw"] = { "ZZ", silent = true },
        ["qa"] = { ":qa<CR>", silent = true },
        ["qe"] = { ":q!<CR>", silent = true },
        ["qf"] = {
          function() require("astrocore.buffer").close() end,
        },
        -- Navigation
        ["w"] = { "b" },
        ["W"] = { "B" },
        ["<S-h>"] = { "^" },
        ["<S-l>"] = { "$" },
        ["J"] = { "<C-d>", remap = true },
        ["K"] = { "<C-u>", remap = true },
        ["}"] = { "]b", remap = true },
        ["{"] = { "[b", remap = true },
        ["<bs>"] = { "<c-o>", desc = "Jump to last position" },
        ["\\"] = { "<c-i>", desc = "Jump to next position" },
        ["[w"] = { "#", desc = "Jump to previous word match" },
        ["]w"] = { "*", desc = "Jump to next word match" },
        ["U"] = { "J" }, -- Up the line
        ["M"] = { "zz" },
        ["b"] = { "<cmd>b#<cr>" },
        -- Git
        ["<Leader>gh"] = false,
        ["<Leader>gR"] = {
          function() require("gitsigns").reset_buffer() end,
          desc = "Reset Git buffer",
        },
        ["<Leader>gr"] = {
          function() require("gitsigns").reset_hunk() end,
          desc = "Reset Git hunk",
        },
        -- Copy, Delete
        ["x"] = { "y", desc = "Copy", remap = true },
        ["X"] = { '"+x', desc = "Copy to system", remap = true },
        ["Xp"] = { '"+p', desc = "Paste from system" },
        ["yx"] = { "yy", desc = "Copy current line" },
        ["yp"] = { '"0p', desc = "paste from copy buffer" },
        ["yP"] = { '"0P', desc = "Paste from copy buffer" },
        ["yf"] = { "<cmd>%y+<cr>", desc = "Copy entire file" },
        ["df"] = { "<cmd>%d<cr>", desc = "Copy entire file" },
        -- Macros
        ["m"] = { "q" },
        [","] = { "Q" },
        -- Extra Functions
        ["<Leader>gg"] = {
          function()
            require("snacks").terminal("lazygit -ucf ~/.config/lazygit/config.yml", {
              win = { position = "float", enter = true },
            })
          end,
          desc = "Lazygit",
        },
        ["<Leader>ld"] = {
          function()
            require("snacks").terminal("lazydocker", {
              win = { position = "float", enter = true },
            })
          end,
          desc = "LazyDocker",
        },
        ["<CR>"] = {
          function()
            if vim.bo.filetype == "man" or vim.bo.filetype == "help" then
              vim.cmd 'execute "tag " . expand("<cword>")'
            else
              require("snacks").picker.lsp_definitions()
            end
          end,
        },
        ["<esc>"] = {
          function() require("noice").cmd "dismiss" end,
        },
        ["<tab>"] = {
          function()
            if require("luasnip").jumpable(1) then
              require("luasnip").jump(1)
            else
              require "functions.goto_lsp_usage"(1)
            end
          end,
        },
        ["<s-tab>"] = {
          function()
            if require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              require "functions.goto_lsp_usage"(-1)
            end
          end,
        },
        ["<Leader>fr"] = {
          function() require("snacks").picker.lsp_references() end,
          desc = "Find LSP references",
        },
        ["<Leader>fd"] = {
          function() require("snacks").picker.diagnostics_buffer() end,
          desc = "Find buffer diagnostics",
        },
      },
      v = {
        -- Remove Mapping
        ["<Leader>/"] = false,
        -- Navigation
        ["w"] = { "b" },
        ["W"] = { "B" },
        ["<S-h>"] = { "^" },
        ["<S-l>"] = { "$" },
        ["J"] = { "Lzz" },
        ["K"] = { "Hzz" },
        -- Copy
        ["x"] = { "y", desc = "Copy", remap = true },
        ["X"] = { '"+x', desc = "Copy", remap = true },
        -- Comment
        ["#"] = { "<cmd>normal gc<cr>" },
        -- Macros
        [","] = { ":'<,'>normal! Q<cr>" },
      },
    },
  },
}
