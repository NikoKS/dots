---@type LazySpec
return {
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
  {
    "Exafunction/codeium.vim",
    event = "User AstroFile",
    config = function()
      vim.keymap.set("i", "<C-Y>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
    end,
  },
  {
    "anurag3301/nvim-platformio.lua",
    event = "User AstroFile",
    dependencies = {
      { "akinsho/nvim-toggleterm.lua" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },
}
