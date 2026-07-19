local M = {}

function M.open_pi()
  require("snacks").terminal("pi", {
    win = {
      position = "right",
      enter = true,
      wo = {
        winhighlight = "Normal:Normal,NormalNC:Normal,SignColumn:Normal,NormalFloat:Normal",
      },
    },
  })
end

function M.send_line_to_pi()
  local win = vim.api.nvim_get_current_win()
  local view = vim.fn.winsaveview()
  vim.cmd "normal! V\027"
  vim.cmd "'<,'>PiSendSelection"
  if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_call(win, function() vim.fn.winrestview(view) end) end
end

function M.send_line_diagnostic_to_pi()
  local bufnr = 0
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lnum = cursor[1] - 1
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

  if vim.tbl_isempty(diagnostics) then
    vim.notify("No diagnostic on current line", vim.log.levels.INFO)
    return
  end

  table.sort(diagnostics, function(a, b)
    return (a.severity or vim.diagnostic.severity.HINT) < (b.severity or vim.diagnostic.severity.HINT)
  end)

  local diagnostic = diagnostics[1]
  local severity = vim.diagnostic.severity[diagnostic.severity] or "UNKNOWN"
  local file = vim.fn.expand "%:p"
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1] or ""
  local source = diagnostic.source and (" [" .. diagnostic.source .. "]") or ""
  local code = diagnostic.code and (" (" .. diagnostic.code .. ")") or ""
  local ft = vim.bo.filetype

  local message = string.format(
    "Explain this diagnostic and suggest a fix.\n\nFile: %s:%d\nDiagnostic: %s%s%s: %s\n\nLine:\n```%s\n%s\n```",
    file,
    lnum + 1,
    severity,
    source,
    code,
    diagnostic.message,
    ft,
    line
  )

  require("pi-nvim").prompt(message)
end

return M
