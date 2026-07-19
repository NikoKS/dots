---@diagnostic disable: undefined-global
local M = {}

local function git_root()
  local root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
  if vim.v.shell_error ~= 0 or not root or root == "" then return nil end
  return root
end

local function relative_to_repo(file)
  if not file or file == "" then return nil end

  -- Lazygit passes paths relative to the repository root, which is exactly what
  -- `git show <ref>:<path>` expects. Keep those unchanged; converting them with
  -- fnamemodify(..., ":p") would incorrectly prepend Neovim's cwd when the cwd
  -- is a subdirectory of the repo.
  if not vim.startswith(file, "/") then return file end

  -- Current-buffer paths are absolute, so convert them back to repo-relative
  -- paths before passing them to git-show.
  local root = git_root()
  if not root then return file end

  local absolute_root = vim.fn.fnamemodify(root, ":p")
  if vim.startswith(file, absolute_root) then return file:sub(#absolute_root + 1) end

  return file
end

function M.open(ref, file)
  if not ref or ref == "" then
    vim.notify("Usage: Gshow <ref> [file]", vim.log.levels.ERROR)
    return
  end

  file = file or vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("No file provided and current buffer has no file name", vim.log.levels.ERROR)
    return
  end

  file = relative_to_repo(file)
  local output = vim.fn.systemlist { "git", "show", ref .. ":" .. file }
  if vim.v.shell_error ~= 0 then
    vim.notify(table.concat(output, "\n"), vim.log.levels.ERROR)
    return
  end

  vim.cmd "enew"
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.modifiable = true

  -- Buffer names must be unique. If the same ref/path is already open, keep the
  -- scratch buffer unnamed rather than failing the command.
  pcall(vim.api.nvim_buf_set_name, 0, ref .. ":" .. file)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
  vim.bo.filetype = vim.filetype.match { filename = file } or ""
  vim.bo.modifiable = false
  vim.bo.readonly = true
end

vim.api.nvim_create_user_command("Gshow", function(opts)
  local ref, file = opts.args:match "^(%S+)%s+(.+)$"
  if not ref then ref = opts.args end
  M.open(ref, file)
end, {
  nargs = "+",
  complete = "file",
  desc = "Open a file as it exists at a git ref. Defaults to the current file.",
})

return M
