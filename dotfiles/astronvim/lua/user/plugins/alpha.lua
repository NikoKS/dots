return {
  layout = {
    { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
    {
      type = "text",
      val = astronvim.user_plugin_opts("header", {
        "███    ██ ██    ██ ██ ███    ███",
        "████   ██ ██    ██ ██ ████  ████",
        "██ ██  ██ ██    ██ ██ ██ ████ ██",
        "██  ██ ██  ██  ██  ██ ██  ██  ██",
        "██   ████   ████   ██ ██      ██",
      }, false),
      opts = { position = "center", hl = "DashboardHeader" },
    },
    { type = "padding", val = 5 },
    {
      type = "group",
      val = {
        astronvim.alpha_button("C - f", "  Find File  "),
        astronvim.alpha_button("LDR s t", "  Search Text  "),
        astronvim.alpha_button("LDR s s", "  Search Session  "),
        astronvim.alpha_button("LDR S l", "  Last Session  "),
        astronvim.alpha_button("LDR f n", "  New File  "),
        astronvim.alpha_button("LDR g g", "  LazyGit  "),
      },
      opts = { spacing = 1 },
    },
  },
  opts = { noautocmd = false },
}
