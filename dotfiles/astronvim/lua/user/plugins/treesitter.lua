return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "sql" },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            aa = "@parameter.outer",
            ia = "@parameter.inner",
          },
        },
      },
      indent = { enable = true, disable = { "python" } },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "User AstroFile",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
