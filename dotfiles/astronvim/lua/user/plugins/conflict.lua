require'git-conflict'.setup({
  default_mappings = {
    ours = 'co',
    theirs = 'ct',
    none = 'c0',
    both = 'cb',
    next = ';gn',
    prev = ';gp',
  },
  disable_diagnostics = true,
})
