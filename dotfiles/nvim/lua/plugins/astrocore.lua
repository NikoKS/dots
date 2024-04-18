local _, luasnip = pcall(require, "luasnip")

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    diagnostics = {
      virtual_text = false,
    },

    options = {
      opt = {
        relativenumber = false,
        clipboard = "",
        iskeyword = vim.opt.iskeyword + { "-" },
      },
      g = {
        python3_host_prog = "~/.local/state/nvim/venv/bin/python",
      },
    },

    filetypes = {
      extension = {
        postcss = "css",
      },
    },

    autocmds = {
      diagnostic_float = {
        {
          event = "CursorHold",
          desc = "Show diagnostics in float",
          pattern = { "*" },
          callback = function() vim.diagnostic.open_float() end,
        },
      },
      python = {
        {
          event = "FileType",
          desc = "Custom config for python files",
          pattern = "python",
          callback = function()
            local map = {
              ["<Leader>rf"] = { '<cmd>SlimeSend0 "python3 " . expand("%:p") . "\\n"<cr>', "Run File" },
              ["<Leader>rp"] = { "<cmd>SlimeSend1 python3<cr>", "Run Python" },
              ["<Leader>re"] = { "<cmd>SlimeSend1 exit()<cr>", "Exit Python" },
            }
            require("which-key").register(map)
          end,
        },
      },
      js = {
        {
          event = "FileType",
          desc = "Custom config for js files",
          pattern = "javascript",
          callback = function()
            local map = {
              ["<Leader>rf"] = { '<cmd>SlimeSend0 "node " . expand("%:p") . "\\n"<cr>', "Run File" },
              ["<Leader>rp"] = { "<cmd>SlimeSend1 node<cr>", "Run node" },
              ["<Leader>re"] = { "<cmd>SlimeSend1 .exit<cr>", "Exit node" },
            }
            require("which-key").register(map)
          end,
        },
      },
      ts = {
        {
          event = "FileType",
          desc = "Custom config for ts files",
          pattern = "typescript",
          callback = function()
            local map = {
              ["<Leader>rf"] = { '<cmd>SlimeSend0 "ts-node " . expand("%:p") . "\\n"<cr>', "Run File" },
            }
            require("which-key").register(map)
          end,
        },
      },
      go = {
        {
          event = "FileType",
          desc = "Custom config for go files",
          pattern = "go",
          callback = function()
            local map = {
              ["<Leader>rf"] = { '<cmd>SlimeSend0 "go run " . expand("%:p") . "\\n"<cr>', "Run File" },
            }
            require("which-key").register(map)
          end,
        },
      },
      rust = {
        {
          event = "FileType",
          desc = "Custom config for rust files",
          pattern = "rust",
          callback = function()
            local map = {
              ["<Leader>rb"] = { "<cmd>SlimeSend1 cargo build<cr>", "Build Project" },
              ["<Leader>rr"] = { "<cmd>SlimeSend1 cargo run<cr>", "Run Project" },
              ["<Leader>rd"] = { "<cmd>cargo doc --open<cr>", "Get Documentation" },
            }
            require("which-key").register(map)
          end,
        },
      },
      buffer = {
        {
          event = "WinEnter",
          desc = "Window enter visual",
          pattern = "*",
          callback = function()
            local config = require("ibl.config").config
            if
              not vim.tbl_contains(config.exclude.filetypes, vim.bo.filetype)
              and not vim.tbl_contains(config.exclude.buftypes, vim.bo.buftype)
            then
              vim.wo.cursorline = true -- Cursor line only on active window
              vim.cmd "IBLEnable"
              vim.diagnostic.show(nil, 0)
            end
          end,
        },
        {
          event = "WinLeave",
          desc = "Window leave visual",
          pattern = "*",
          callback = function()
            local config = require("ibl.config").config
            if
              not vim.tbl_contains(config.exclude.filetypes, vim.bo.filetype)
              and not vim.tbl_contains(config.exclude.buftypes, vim.bo.buftype)
            then
              vim.wo.cursorline = false
              vim.cmd "IBLDisable"
              vim.diagnostic.hide(nil, 0)
            end
          end,
        },
      },
    },

    mappings = {
      -- first key is the mode
      n = {
        -- Disable default mappings
        ["<Leader>/"] = false,
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<Leader>o"] = false,
        ["<Leader>h"] = false,
        ["<Leader>q"] = false,
        ["<Leader>Q"] = false,
        ["q"] = "<nop>", -- <nop> for vim defaults
        -- General/Utility
        ["r"] = { "<C-r>" }, -- Redo
        ["R"] = { "<cmd>e!<CR>" },
        ["#"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>" },
        [" "] = { "za" },
        ["<Leader>a"] = { "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },
        ["?"] = { "<cmd>lua vim.lsp.buf.hover()<cr>" },
        ["="] = { "<c-w>=" },
        ["<C-f>"] = { "<cmd>Telescope find_files<cr>", desc = "Find File" },
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
            require("astrocore").toggle_term_cmd { cmd = "lazygit -ucd ~/.config/lazygit", direction = "float" }
          end,
          desc = "Lazygit",
        },
        ["<Leader>ld"] = {
          function() require("astrocore").toggle_term_cmd "lazydocker" end,
          desc = "LazyDocker",
        },
        ["<CR>"] = {
          function()
            if vim.bo.filetype == "man" or vim.bo.filetype == "help" then
              vim.cmd 'execute "tag " . expand("<cword>")'
            else
              vim.cmd "Telescope lsp_definitions"
            end
          end,
        },
        ["<esc>"] = {
          function() require("notify").dismiss { pending = false, silent = false } end,
        },
        ["<tab>"] = {
          function()
            if luasnip.jumpable() then
              luasnip.jump(1)
            else
              require("nvim-treesitter-refactor.navigation").goto_next_usage()
            end
          end,
        },
        ["<s-tab>"] = {
          function() require("nvim-treesitter-refactor.navigation").goto_previous_usage() end,
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
        ["#"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" },
        -- Macros
        [","] = { ":'<,'>normal! Q<cr>" },
      },
    },
  },
}
