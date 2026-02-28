---@type LazySpec[]
local plugins = {
  "AstroNvim/astrocommunity",

  -- Colorscheme
  { import = "astrocommunity.colorscheme.github-nvim-theme", opts = {
    transparent = true,
  } },

  -- utility
  { import = "astrocommunity.project.project-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  {
    "kylechui/nvim-surround",
    config = function()
      vim.keymap.set("n", "s", "<Plug>(nvim-surround-normal)", {
        desc = "Add a surrounding pair around a motion (normal mode)",
      })
      vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)", {
        desc = "Add a surrounding pair around a visual selection",
      })
    end,
  },
  { import = "astrocommunity.syntax.vim-easy-align" },
  {
    "junegunn/vim-easy-align",
    config = function() vim.keymap.set("x", "<Leader>e", "<Plug>(EasyAlign)", { desc = "Easy Align" }) end,
  },
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = { presets = { lsp_doc_border = true } },
  },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  -- { import = "astrocommunity.git.neogit" },
}

local nonremote = {
  { import = "astrocommunity.scrolling.mini-animate" },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = { input = { enabled = true }, picker = { enabled = true }, terminal = { enabled = true } },
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>o"
          maps.n[prefix] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
          maps.n[prefix .. "o"] = {
            function() require("opencode").toggle() end,
            desc = "Toggle embedded",
          }
          maps.n["<Leader>" .. "a"] = {
            function() require("opencode").ask "@this: " end,
            desc = "Ask about this",
          }
          maps.n[prefix .. "+"] = {
            function() require("opencode").prompt("@buffer", { append = true }) end,
            desc = "Add buffer to prompt",
          }
          maps.n[prefix .. "e"] = {
            function() require("opencode").prompt "Explain @this and its context" end,
            desc = "Explain this code",
          }
          maps.n[prefix .. "n"] = {
            function() require("opencode").command "session_new" end,
            desc = "New session",
          }
          maps.n[prefix .. "s"] = {
            function() require("opencode").select() end,
            desc = "Select prompt",
          }
          maps.n["<S-C-u>"] = {
            function() require("opencode").command "messages_half_page_up" end,
            desc = "Messages half page up",
          }
          maps.n["<S-C-d>"] = {
            function() require("opencode").command "messages_half_page_down" end,
            desc = "Messages half page down",
          }

          maps.v[prefix] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
          maps.v["<Leader>" .. "a"] = {
            function() require("opencode").ask "@this: " end,
            desc = "Ask about selection",
          }
          maps.v[prefix .. "+"] = {
            function() require("opencode").prompt "@this" end,
            desc = "Add selection to prompt",
          }
          maps.v[prefix .. "s"] = {
            function() require("opencode").select() end,
            desc = "Select prompt",
          }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { OpenCode = "" } } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true
    end,
  },
  -- Language
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.prettier" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.nginx" },
}

-- Plugins excluded in remote environment
if os.getenv "SSH_TTY" == nil then
  for _, v in ipairs(nonremote) do
    table.insert(plugins, v)
  end
end

return plugins
