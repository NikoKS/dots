-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

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
  { import = "astrocommunity.git.codediff-nvim" },
}

local nonremote = {
  { import = "astrocommunity.scrolling.mini-animate" },
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
