local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local telescope_custom_actions = {}

local gs = require("gitsigns")

function telescope_custom_actions.diffthis(prompt_bufnr)
	local selected_entry = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  gs.diffthis(selected_entry.value)
end

function telescope_custom_actions.printname(prompt_bufnr)
  local selected_entry = action_state.get_selected_entry()
  print(selected_entry.value)
end


lvim.builtin.telescope.defaults.mappings = {
	i = {
		["<Tab>"] = actions.move_selection_next,
		["<S-Tab>"] = actions.move_selection_previous,
	},
	n = {
		["<Tab>"] = actions.move_selection_next,
		["<S-Tab>"] = actions.move_selection_previous,
		["<S-j>"] = actions.preview_scrolling_down,
		["<S-k>"] = actions.preview_scrolling_up,
		["<space>"] = actions.toggle_selection,
		["q"] = actions.send_selected_to_qflist + actions.open_qflist,
		["w"] = function()
			vim.cmd([[execute "normal! b"]])
		end,
		["W"] = function()
			vim.cmd([[execute "normal! B"]])
		end,
    ["n"] = telescope_custom_actions.printname
	},
}

lvim.builtin.telescope.pickers = {
	git_branches = {
		mappings = {
			n = {
				["d"] = telescope_custom_actions.diffthis
			},
		},
	},
}
