return {
  default_component_configs = {
    git_status = {
      symbols = {
        untracked = "ﱐ"
      }
    }
  },
  filesystem = {
    follow_current_file = true
  },
  window = {
    mappings = {
      ["<space>"] = "toggle_node",
      ["["] = "prev_source",
      ["]"] = "next_source",
      ["]g"] = false,
      ["[g"] = false,
      ["f"] = false,
      ["L"] = false,
      ["H"] = false,
      ["w"] = false,
    }
  }
}
