-- AstroCore autocommands are configured separately to keep the core settings focused.
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      markdown = {
        {
          event = "FileType",
          desc = "Enable wrapping for Markdown files",
          pattern = { "markdown", "markdown.mdx" },
          callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
          end,
        },
      },
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
              {
                "<Leader>rf",
                '<cmd>SlimeSend0 "node " . expand("%:p") . "\\n"<cr>',
                desc = "Run File",
                buffer = true,
              },
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
      neotree_term = {
        {
          event = "TermClose",
          desc = "Refresh neo-tree when terminal closes",
          pattern = "term://*",
          callback = function()
            vim.schedule(function() require("neo-tree.sources.git_status").refresh() end)
          end,
        },
      },
    },
  },
}
