return {
  ensure_installed = { "tsx", "typescript", "javascript", "go", "astro", "css" },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- aB = "@block.outer",
        -- iB = "@block.inner",
        -- aC = "@conditional.outer",
        -- iC = "@conditional.inner",
        -- aF = "@function.outer",
        -- iF = "@function.inner",
        -- aL = "@loop.outer",
        -- iL = "@loop.inner",
        aa = "@parameter.outer",
        ia = "@parameter.inner",
        -- aX = "@class.outer",
        -- iX = "@class.inner",
      },
    },
  },
}
