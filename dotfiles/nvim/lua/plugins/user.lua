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
    },
  },

  -- DISABLE
  { "max397574/better-escape.nvim", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },

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
  {
    "tpope/vim-fugitive",
    event = "User AstroFile",
  },
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
}
