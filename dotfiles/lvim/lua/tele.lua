local actions = require("telescope.actions")
local action_state = require('telescope.actions.state')

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("cfdo " .. open_cmd)
end
function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "split")
end
function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
end
function telescope_custom_actions.multi_selection_open(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

lvim.builtin.telescope.defaults.mappings = {
  i = {
    -- ["<cr>"] = telescope_custom_actions.multi_selection_open,
    ["<Tab>"] = actions.move_selection_next,
    ["<S-Tab>"] = actions.move_selection_previous,
  },
  n = {
    -- ["<cr>"] = telescope_custom_actions.multi_selection_open,
    ["<Tab>"] = actions.move_selection_next,
    ["<S-Tab>"] = actions.move_selection_previous,
    ["<S-j>"] = actions.preview_scrolling_down,
    ["<S-k>"] = actions.preview_scrolling_up,
    ["<space>"] = actions.toggle_selection,
    ["q"] = actions.send_selected_to_qflist + actions.open_qflist,
    -- ["p"] = actions.paste,
    ["w"] = function ()
      vim.cmd([[execute "normal! b"]])
    end,
    ["W"] = function ()
      vim.cmd([[execute "normal! B"]])
    end,
  }
}
