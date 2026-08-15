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
        filter = function(buf, _)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },
      picker = {
        actions = {
          cycle_win_back = require "functions.picker_cycle_win_back",
        },
        win = {
          input = {
            keys = {
              ["<Tab>"] = { "cycle_win", mode = { "n", "i" } },
              ["<S-Tab>"] = { "cycle_win_back", mode = { "n", "i" } },
              ["J"] = { "preview_scroll_down", mode = { "n", "i" } },
              ["K"] = { "preview_scroll_up", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["<Tab>"] = { "cycle_win", mode = { "n", "x" } },
              ["<S-Tab>"] = { "cycle_win_back", mode = { "n", "x" } },
              ["J"] = { "preview_scroll_down", mode = { "n", "x" } },
              ["K"] = { "preview_scroll_up", mode = { "n", "x" } },
            },
          },
          preview = {
            keys = {
              ["<Tab>"] = { "cycle_win", mode = { "n", "x" } },
              ["<S-Tab>"] = { "cycle_win_back", mode = { "n", "x" } },
            },
          },
        },
        sources = {
          files = {
            hidden = true,
            ignored = true,
          },
          git_log = {
            confirm = function(picker, item)
              if not item or not item.commit then return end

              picker:close()
              vim.schedule(function() vim.cmd("CodeDiff file " .. item.commit) end)
            end,
          },
          git_log_file = {
            confirm = function(picker, item)
              if not item or not item.commit then return end

              picker:close()
              vim.schedule(function() vim.cmd("CodeDiff file " .. item.commit) end)
            end,
          },
          git_log_line = {
            confirm = function(picker, item)
              if not item or not item.commit then return end

              picker:close()
              vim.schedule(function() vim.cmd("CodeDiff file " .. item.commit) end)
            end,
          },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}
      opts.window.mappings["<C-f>"] = false

      opts.filesystem = opts.filesystem or {}
      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      opts.filesystem.window.mappings["f"] = false
      opts.filesystem.window.mappings["/"] = false
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      at_edge = "stop",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local on_attach = opts.on_attach
      opts.on_attach = function(bufnr)
        if on_attach then on_attach(bufnr) end

        vim.keymap.set(
          "n",
          "<Leader>gd",
          function() vim.cmd "CodeDiff file HEAD" end,
          { buffer = bufnr, desc = "CodeDiff current file with HEAD", silent = true }
        )
      end
    end,
  },
  {
    "vuki656/package-info.nvim",
    opts = {
      -- Disable the plugin's unconditional BufEnter autostart; we add a guarded
      -- one below so CodeDiff/package.json merge views don't run `npm outdated`.
      autostart = false,
    },
    config = function(_, opts)
      require("package-info").setup(opts)

      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("PackageInfoAutostart", { clear = true }),
        pattern = "package.json",
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname:match "^codediff://" then return end

          local ok, lifecycle = pcall(require, "codediff.ui.lifecycle")
          if ok and lifecycle.get_session(vim.api.nvim_get_current_tabpage()) then return end

          require("package-info").show()
        end,
      })
    end,
  },

  -- DISABLE
  { "max397574/better-escape.nvim", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },
  { "akinsho/toggleterm.nvim", enabled = false },

  -- ADDITIONAL
  {
    "folke/flash.nvim",
    event = "User AstroFile",
    opts = {
      modes = { char = { enabled = false } },
    },
    keys = {
      {
        "f",
        function()
          require("flash").jump {
            search = { forward = true, wrap = false, multi_window = false, max_length = 1 },
          }
        end,
        mode = { "n", "x" },
        desc = "Flash character forward",
      },
      {
        "F",
        function()
          require("flash").jump {
            search = { forward = false, wrap = false, multi_window = false, max_length = 1 },
          }
        end,
        mode = { "n", "x" },
        desc = "Flash character backward",
      },
    },
  },
  {
    "jpalardy/vim-slime",
    lazy = false,
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
    "carderne/pi-nvim",
    config = function()
      require("pi-nvim").setup {
        set_default_keymaps = false,
      }

      local snacks_terminal = require "functions.snacks_terminal"

      require("which-key").add {
        { "<Leader>a", group = "AI" },
        {
          "<Leader>ai",
          snacks_terminal.open_pi,
          desc = "Open pi",
        },
        {
          "<Leader>as",
          snacks_terminal.send_line_to_pi,
          mode = { "n" },
          desc = "Send line to pi",
        },
        {
          "<Leader>as",
          ":PiSendSelection<cr>",
          mode = { "v" },
          desc = "Send selection to pi",
        },
        {
          "<Leader>ac",
          snacks_terminal.copy_selection_with_context,
          mode = { "v" },
          desc = "Copy selection with context",
        },
        {
          "<Leader>ad",
          snacks_terminal.send_line_diagnostic_to_pi,
          desc = "Explain line diagnostic",
        },
        {
          "<Leader>af",
          "<cmd>PiSendFile<cr>",
          desc = "Send file path to pi",
        },
        {
          "<Leader>aa",
          "<cmd>PiSend<cr>",
          desc = "Send to pi",
        },
      }
    end,
  },
}
