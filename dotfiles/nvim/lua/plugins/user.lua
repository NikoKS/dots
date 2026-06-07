-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- CUSTOMIZATION
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
      indent = {
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the
          -- top-level scope which will be rendered as a scope.
          enabled = true,
        },
        -- filter for buffers to enable indent guides
        ---@param buf number
        ---@param win number
        filter = function(buf, win)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<Tab>"] = { "cycle_win", mode = { "n", "i" } },
              ["J"] = { "preview_scroll_down", mode = { "n", "i" } },
              ["K"] = { "preview_scroll_up", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["<Tab>"] = { "cycle_win", mode = { "n", "x" } },
              ["J"] = { "preview_scroll_down", mode = { "n", "x" } },
              ["K"] = { "preview_scroll_up", mode = { "n", "x" } },
            },
          },
          preview = {
            keys = {
              ["<Tab>"] = { "cycle_win", mode = { "n", "x" } },
            },
          },
        },
      },
    },
  },

  -- DISABLE
  { "max397574/better-escape.nvim", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },
  { "akinsho/toggleterm.nvim", enabled = false },

  -- ADDITIONAL
  {
    "smoka7/hop.nvim",
    event = "User AstroFile",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    keys = {
      {
        "f",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.AFTER_CURSOR,
            current_line_only = false,
          }
        end,
        mode = { "n", "x" },
        desc = "Hop char 1 forward",
      },
      {
        "F",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
            current_line_only = false,
          }
        end,
        mode = { "n", "x" },
        desc = "Hop char 1 backward",
      },
    },
  },
  -- {
  --   "tpope/vim-fugitive",
  --   event = "User AstroFile",
  -- },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").add { { "<Leader>c", group = " Conflict" } }
      require("git-conflict").setup {
        default_mappings = {
          ours = "<Leader>co",
          theirs = "<Leader>ct",
          none = "<Leader>cn",
          both = "<Leader>cb",
          next = "]c",
          prev = "[c",
        },
        disable_diagnostics = true,
      }
    end,
  },
  {
    "jpalardy/vim-slime",
    event = "User AstroFile",
    config = function()
      vim.cmd [[
  		let g:slime_paste_file = tempname()
  		let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom-right}"}
			]]
      vim.g["slime_target"] = "tmux"
      vim.g["slime_dont_ask_default"] = 1
      vim.g["autosource_disable_autocmd"] = 1
      vim.keymap.set("v", "<cr>", "<Plug>SlimeRegionSend")
      require("which-key").add {
        { "<Leader>r", group = " Run" },
        { "<Leader>rw", '<cmd>SlimeSend0 "cd " . getcwd() . "\\n"<cr>', desc = "Change to Working Directory" },
        { "<Leader>rc", '<cmd>SlimeSend0 "\x03"<cr>', desc = "Ctrl-C" },
        {
          "<Leader>rl",
          "<cmd>SlimeSend1 docker compose logs -f | rg 'WARNING|ERROR|CRITICAL' <cr>",
          desc = "Docker Compose Logs",
        },
        {},
      }
    end,
  },
  { "jenterkin/vim-autosource", lazy = false },
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      local opencode_cmd = "opencode --port"
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = "right",
          enter = true,
        },
      }

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function() require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts) end,
        },
      }

      vim.o.autoread = true

      require("which-key").add { { "<Leader>o", group = "Opencode" } }

      vim.keymap.set(
        { "n", "t" },
        "<leader>oo",
        function() require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts) end,
        { desc = "Toggle opencode" }
      )

      vim.keymap.set(
        { "n", "x" },
        "<leader>oa",
        function() require("opencode").ask "@this: " end,
        { desc = "Ask opencode about line" }
      )

      vim.keymap.set(
        { "n", "x" },
        "<leader>ob",
        function() require("opencode").ask "@buffer: " end,
        { desc = "Ask opencode about buffer" }
      )
    end,
  },
}
