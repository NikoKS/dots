return function(picker)
  local wins = { picker.input.win.win, picker.preview.win.win, picker.list.win.win }
  if type(vim.g.snacks_picker_cycle_win) == "number" then table.insert(wins, 3, vim.g.snacks_picker_cycle_win) end
  wins = vim.tbl_filter(vim.api.nvim_win_is_valid, wins)

  local index = 1
  for i, win in ipairs(wins) do
    if win == vim.api.nvim_get_current_win() then
      index = i
      break
    end
  end
  vim.api.nvim_set_current_win(wins[(index - 2) % #wins + 1])
end
