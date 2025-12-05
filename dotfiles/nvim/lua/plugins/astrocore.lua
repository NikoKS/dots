---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false,
      underline = true,
      float = {
        focusable = false,
      },
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        postcss = "css",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        clipboard = "",
        iskeyword = vim.opt.iskeyword + { "-" },
      },
      g = { -- vim.g.<key>
        python3_host_prog = "~/.local/state/nvim/venv/bin/python",
      },
    },
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
        ["q"] = "<nop>", -- <nop> for vim defaults
        -- General/Utility
        ["r"] = { "<C-r>" }, -- Redo
        ["R"] = { "<cmd>execute'LspRestart'|e!<CR>" },
        ["#"] = { "<cmd>normal gcc<cr>" },
        [" "] = { "za" },
        ["<Leader>o"] = { "<cmd>AerialToggle<cr>", desc = "Toggle Outline" },
        ["?"] = { "<cmd>lua vim.lsp.buf.hover()<cr>" },
        ["="] = { "<c-w>=" },
        ["<C-f>"] = { function() require("snacks").picker.files() end, desc = "Find File" },
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
            require("astrocore").toggle_term_cmd {
              cmd = "lazygit -ucf ~/.config/lazygit/config.yml",
              display_name = "lazygit",
              direction = "float",
            }
          end,
          desc = "Lazygit",
        },
        ["<Leader>ld"] = {
          function() require("astrocore").toggle_term_cmd { cmd = "lazydocker", direction = "float" } end,
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
            if require("luasnip").jumpable() then
              require("luasnip").jump(1)
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
        ["#"] = { "<cmd>normal gc<cr>" },
        -- Macros
        [","] = { ":'<,'>normal! Q<cr>" },
      },
    },
    autocmds = {
      python = {
        {
          event = "FileType",
          desc = "Custom config for python files",
          pattern = "python",
          callback = function()
            require("which-key").add {
              { "<Leader>re", "<cmd>SlimeSend1 exit()<cr>", desc = "Exit Python", buffer = true },
              {
                "<Leader>rf",
                '<cmd>SlimeSend0 "python3 " . expand("%:p") . "\\n"<cr>',
                desc = "Run File",
                buffer = true,
              },
              { "<Leader>rp", "<cmd>SlimeSend1 python3<cr>", desc = "Run Python", buffer = true },
            }
          end,
        },
      },
      js = {
        {
          event = "FileType",
          desc = "Custom config for js files",
          pattern = "javascript",
          callback = function()
            require("which-key").add {
              { "<Leader>re", "<cmd>SlimeSend1 .exit<cr>", desc = "Exit node", buffer = true },
              { "<Leader>rf", '<cmd>SlimeSend0 "node " . expand("%:p") . "\\n"<cr>', desc = "Run File", buffer = true },
              { "<Leader>rp", "<cmd>SlimeSend1 node<cr>", desc = "Run node", buffer = true },
            }
          end,
        },
      },
      ts = {
        {
          event = "FileType",
          desc = "Custom config for ts files",
          pattern = "typescript",
          callback = function()
            require("which-key").add {
              {
                "<Leader>rf",
                '<cmd>SlimeSend0 "ts-node " . expand("%:p") . "\\n"<cr>',
                desc = "Run File",
                buffer = true,
              },
            }
          end,
        },
      },
      go = {
        {
          event = "FileType",
          desc = "Custom config for go files",
          pattern = "go",
          callback = function()
            require("which-key").add {
              {
                "<Leader>rf",
                '<cmd>SlimeSend0 "go run " . expand("%:p") . "\\n"<cr>',
                desc = "Run File",
                buffer = true,
              },
            }
          end,
        },
      },
      rust = {
        {
          event = "FileType",
          desc = "Custom config for rust files",
          pattern = "rust",
          callback = function()
            require("which-key").add {
              { "<Leader>rb", "<cmd>SlimeSend1 cargo build<cr>", desc = "Build Project", buffer = true },
              { "<Leader>rd", "<cmd>cargo doc --open<cr>", desc = "Get Documentation", buffer = true },
              { "<Leader>rr", "<cmd>SlimeSend1 cargo run<cr>", desc = "Run Project", buffer = true },
            }
          end,
        },
      },
      toggleterm_neotree = {
        {
          event = "TermClose",
          desc = "Refresh neo-tree when toggleterm closes",
          pattern = "term://*",
          callback = function()
            vim.schedule(function() require("neo-tree.sources.git_status").refresh() end)
          end,
        },
      },
    },
  },
}
