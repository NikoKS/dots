local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local flatten = vim.tbl_flatten
local make_entry = require("telescope.make_entry")

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
		["n"] = telescope_custom_actions.printname,
	},
}

lvim.builtin.telescope.pickers = {
	git_branches = {
		mappings = {
			n = {
				["d"] = telescope_custom_actions.diffthis,
			},
		},
	},
}

-- Custom picker
local M = {}
M.file_contains = function(opts)
	opts = opts or {}

	local live_grepper = finders.new_job(function(prompt)
		if not prompt or prompt == "" then
			return nil
		end

		return { "rg", "-U", "-l", "--multiline-dotall", prompt }
	end)

	pickers.new(opts, {
		prompt_title = "File Contains Word",
		finder = live_grepper,
		previewer = previewers.grep_previewer,
	}):find()
end

return M
