local cache = {}

local function cursor_in_range(position, range)
  local after_start = position.line > range.start.line
    or (position.line == range.start.line and position.character >= range.start.character)
  local before_end = position.line < range["end"].line
    or (position.line == range["end"].line and position.character < range["end"].character)
  return after_start and before_end
end

local function find_client(bufnr)
  local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/documentHighlight" }
  if #clients > 0 then return clients[1], "textDocument/documentHighlight" end

  clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/references" }
  if #clients > 0 then return clients[1], "textDocument/references" end
end

local function goto_location(locations, cursor, direction)
  table.sort(locations, function(a, b)
    return a.lnum == b.lnum and a.col < b.col or a.lnum < b.lnum
  end)

  local target
  for _, location in ipairs(locations) do
    local after = location.lnum > cursor[1] or (location.lnum == cursor[1] and location.col > cursor[2] + 1)
    local before = location.lnum < cursor[1] or (location.lnum == cursor[1] and location.col < cursor[2] + 1)
    if (direction > 0 and after) or (direction < 0 and before) then
      target = location
      if direction > 0 then break end
    end
  end
  target = target or (direction > 0 and locations[1] or locations[#locations])
  if target then vim.api.nvim_win_set_cursor(0, { target.lnum, target.col - 1 }) end
end

return function(direction)
  local bufnr = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local client, method = find_client(bufnr)
  if not client then return end

  local tick = vim.api.nvim_buf_get_changedtick(bufnr)
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
  local entry = cache[bufnr]
  if entry and entry.tick == tick and entry.client_id == client.id and entry.method == method then
    for _, range in ipairs(entry.ranges) do
      if cursor_in_range(params.position, range) then
        goto_location(entry.locations, vim.api.nvim_win_get_cursor(win), direction)
        return
      end
    end
  end

  local uri = vim.uri_from_bufnr(bufnr)
  local cursor = vim.api.nvim_win_get_cursor(win)
  local timer = vim.uv.new_timer()
  local finished = false

  local function finish(result)
    if finished then return end
    finished = true
    timer:stop()
    timer:close()

    local ranges = {}
    local locations = {}
    for _, item in ipairs(result or {}) do
      local range = item.range
      local item_uri = item.uri or uri
      if item_uri == uri and range then
        table.insert(ranges, range)
        local location = vim.lsp.util.locations_to_items({ { uri = uri, range = range } }, client.offset_encoding)[1]
        if location then table.insert(locations, location) end
      end
    end
    cache[bufnr] = { tick = tick, client_id = client.id, method = method, ranges = ranges, locations = locations }
    goto_location(locations, cursor, direction)
  end

  if method == "textDocument/references" then params.context = { includeDeclaration = true } end
  local request_id
  local timeout = method == "textDocument/documentHighlight" and 300 or 500
  timer:start(timeout, 0, vim.schedule_wrap(function()
    if request_id then client:cancel_request(request_id) end
    finish()
  end))
  local requested
  requested, request_id = client:request(method, params, function(err, result)
    if err then result = {} end
    finish(result)
  end, bufnr)
  if not requested then finish() end
end
