return function(local_vim)
	local_vim.opt.relativenumber = false
	local_vim.opt.clipboard = ""
	local_vim.opt.iskeyword = vim.opt.iskeyword + { "-" }

	local_vim.g.mapleader = ";"
	local_vim.g.python3_host_prog = "~/.local/state/nvim/venv/bin/python"
	return local_vim
end
