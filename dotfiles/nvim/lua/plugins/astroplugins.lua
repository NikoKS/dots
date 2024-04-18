local actions = require "telescope.actions"

---@type LazySpec
return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["<space>"] = "toggle_node",
        },
      },
      filesystem = {
        bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      keymaps = {
        [" "] = "actions.tree_toggle",
        ["M"] = "actions.scroll",
      },
      manage_folds = true,
      link_folds_to_tree = false,
      link_tree_to_folds = false,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,
          },
          n = {
            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,
            ["<S-j>"] = actions.preview_scrolling_down,
            ["<S-k>"] = actions.preview_scrolling_up,
            ["<space>"] = actions.toggle_selection,
            ["w"] = function() vim.cmd [[execute "normal! b"]] end,
            ["W"] = function() vim.cmd [[execute "normal! B"]] end,
          },
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, config)
      local null_ls = require "null-ls"

      config.sources = {
        -- null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "88" } }),
        -- null_ls.builtins.diagnostics.pydocstyle.with({ extra_args = { "--convention", "google" } }),
        null_ls.builtins.formatting.prettierd.with { extra_filetypes = { "svelte", "astro", "xml" } },
      }
      return config
    end,
  },
  {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "lua", "sql" },
        auto_install = true,
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              aa = "@parameter.outer",
              ia = "@parameter.inner",
              aA = "@attribute.outer",
              iA = "@attribute.inner",
            },
          },
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "User AstroFile",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
      "nvim-treesitter/nvim-treesitter-refactor",
      event = "User AstroFile",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
