---@type LazySpec
local plugins = {
  "AstroNvim/astrocommunity",

  -- Colorscheme
  { import = "astrocommunity.colorscheme.github-nvim-theme" },

  -- utility
  { import = "astrocommunity.project.project-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  {
    "kylechui/nvim-surround",
    opts = { keymaps = { normal = "s", visual = "s" } },
  },
  { import = "astrocommunity.syntax.vim-easy-align" },
  {
    "junegunn/vim-easy-align",
    config = function() vim.keymap.set("x", "<Leader>a", "<Plug>(EasyAlign)", { desc = "Easy Align" }) end,
  },
}

local nonremote = {
  { import = "astrocommunity.scrolling.mini-animate" },
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = { presets = { lsp_doc_border = true } },
  },

  -- Language
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.terraform" },
}

-- Plugins excluded in remote environment
if os.getenv "SSH_TTY" == nil then
  for _, v in ipairs(nonremote) do
    table.insert(plugins, v)
  end
end

return plugins
