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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>a"

          maps.n[prefix] = { desc = "Avante" }

          maps.n[prefix .. "a"] = { function() require("avante.api").ask() end, desc = "Avante ask" }
          maps.v[prefix .. "a"] = { function() require("avante.api").ask() end, desc = "Avante ask" }

          maps.v[prefix .. "r"] = { function() require("avante.api").refresh() end, desc = "Avante refresh" }

          maps.n[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Avante edit" }
          maps.v[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Avante edit" }

          -- the following key bindings do not have an official api implementation
          -- maps.n.co = { "<Plug>(AvanteConflictOurs)", desc = "Choose ours", expr = true }
          -- maps.v.co = { "<Plug>(AvanteConflictOurs)", desc = "Choose ours", expr = true }
          --
          -- maps.n.ct = { "<Plug>(AvanteConflictTheirs)", desc = "Choose theirs", expr = true }
          -- maps.v.ct = { "<Plug>(AvanteConflictTheirs)", desc = "Choose theirs", expr = true }
          --
          -- maps.n.ca = { "<Plug>(AvanteConflictAllTheirs)", desc = "Choose all theirs", expr = true }
          -- maps.v.ca = { "<Plug>(AvanteConflictAllTheirs)", desc = "Choose all theirs", expr = true }
          --
          -- maps.n.cb = { "<Plug>(AvanteConflictBoth)", desc = "Choose both", expr = true }
          -- maps.v.cb = { "<Plug>(AvanteConflictBoth)", desc = "Choose both", expr = true }
          --
          -- maps.n.cc = { "<Plug>(AvanteConflictCursor)", desc = "Choose cursor", expr = true }
          -- maps.v.cc = { "<Plug>(AvanteConflictCursor)", desc = "Choose cursor", expr = true }
          --
          -- maps.n["]x"] = { "<Plug>(AvanteConflictPrevConflict)", desc = "Move to previous conflict", expr = true }
          --
          -- maps.n["[x"] = { "<Plug>(AvanteConflictNextConflict)", desc = "Move to next conflict", expr = true }
        end,
      },
    },
  },
  -- {
  --   "amitds1997/remote-nvim.nvim",
  --   version = "*", -- Pin to GitHub releases
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- For standard functions
  --     "MunifTanjim/nui.nvim", -- To build the plugin UI
  --     "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
  --   },
  --   config = true,
  -- },
}
