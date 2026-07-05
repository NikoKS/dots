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
        sources = {
          files = {
            hidden = true,
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

      local function send_line_diagnostic_to_pi()
        local bufnr = 0
        local cursor = vim.api.nvim_win_get_cursor(0)
        local lnum = cursor[1] - 1
        local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

        if vim.tbl_isempty(diagnostics) then
          vim.notify("No diagnostic on current line", vim.log.levels.INFO)
          return
        end

        table.sort(diagnostics, function(a, b)
          return (a.severity or vim.diagnostic.severity.HINT) < (b.severity or vim.diagnostic.severity.HINT)
        end)

        local diagnostic = diagnostics[1]
        local severity = vim.diagnostic.severity[diagnostic.severity] or "UNKNOWN"
        local file = vim.fn.expand("%:p")
        local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1] or ""
        local source = diagnostic.source and (" [" .. diagnostic.source .. "]") or ""
        local code = diagnostic.code and (" (" .. diagnostic.code .. ")") or ""
        local ft = vim.bo.filetype

        local message = string.format(
          "Explain this diagnostic and suggest a fix.\n\nFile: %s:%d\nDiagnostic: %s%s%s: %s\n\nLine:\n```%s\n%s\n```",
          file,
          lnum + 1,
          severity,
          source,
          code,
          diagnostic.message,
          ft,
          line
        )

        require("pi-nvim").prompt(message)
      end

      require("which-key").add {
        { "<Leader>a", group = "AI" },
        {
          "<Leader>ai",
          function()
            require("snacks").terminal("pi", {
              win = {
                position = "right",
                enter = true,
                wo = {
                  winhighlight = "Normal:Normal,NormalNC:Normal,SignColumn:Normal,NormalFloat:Normal",
                },
              },
            })
          end,
          desc = "Open pi",
        },
        {
          "<Leader>as",
          function()
            local keys = vim.api.nvim_replace_termcodes("V:PiSendSelection<CR>", true, false, true)
            vim.api.nvim_feedkeys(keys, "nx", false)
          end,
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
          "<Leader>ad",
          send_line_diagnostic_to_pi,
          desc = "Explain line diagnostic",
        },
        {
          "<Leader>ab",
          "<cmd>PiSendBuffer<cr>",
          desc = "Send Buffer to pi",
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
