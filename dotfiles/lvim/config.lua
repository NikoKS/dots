-- Latest stable lvim
-- e8693406babee724dd51293dc6dad10931dbef45

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "material" -- Consider https://github.com/EdenEast/nightfox.nvim
lvim.leader = ";"
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
vim.cmd('set cmdheight=1')
vim.cmd("set timeoutlen=300")
vim.opt.clipboard = ''

-- Unmaping. Unfortunately need to do this since Lvim has a lot of default mappings
lvim.keys.normal_mode["<S-l>"] = nil
lvim.keys.normal_mode["<S-h>"] = nil
lvim.keys.normal_mode["[q"] = nil
lvim.keys.normal_mode["]q"] = nil
lvim.keys.visual_block_mode["J"] = nil
lvim.keys.visual_block_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
vim.api.nvim_set_keymap('n', '[%', '<nop>', {})
vim.api.nvim_set_keymap('n', ']%', '<nop>', {})
lvim.builtin.which_key.setup.triggers_blacklist = {
  n = {"[", "]"}
}

-- change lazygit exec
lvim.builtin.terminal.execs = {{"lazygit -ucd ~/.config/lazygit", "gg", "LazyGit"}}
-- vsplit
lvim.builtin.which_key.mappings["v"] = { ":vs<CR>" , "VerticalSplit"}

-- General Keymaps
vim.cmd([[
  map <silent> <space> @@
  nnoremap v <C-v>
  nnoremap r <C-r>
  nnoremap <BS> J
  nnoremap gm %
  nmap ;n <c-g>
  nmap <tab> %
  nmap # ;/
  vmap # ;/
]])

-- Extra commands
vim.cmd([[
  nnoremap <silent> <esc> :noh<return><esc>
  nnoremap <silent> R :e<CR>
]])

-- Sensible selection
vim.cmd([[
  nnoremap cw ciw
  nnoremap cW ciW
  nnoremap dw daw
  nnoremap dW daW
  nnoremap cn cgn
  nnoremap cN cgN
  nnoremap yw yiw
  nnoremap yW yiW
  nnoremap ca ggVGc
  nnoremap da ggVGd
]])

-- Remap copy paste
vim.cmd([[
  map x y
  map " "+
  nnoremap dp "1p
  nnoremap dP "1P
  nnoremap xp "0p
  nnoremap xP "0P
  nnoremap 'p "zp
  nnoremap 'P "zP
  noremap 'x "zy
  nnoremap xa ggVG"+y
]])

-- Navigation keymappings
vim.cmd([[
  nmap t ;bf
  nnoremap J Lzz
  vnoremap J Lzz
  nnoremap K Hzz
  vnoremap K Hzz
  nnoremap L $
  vnoremap L $
  nnoremap H ^
  vnoremap H ^
  nnoremap w b
  vnoremap w b
  nnoremap W B
  vnoremap W B
  nnoremap <nowait> > >>
  nnoremap <nowait> < <<
  nnoremap <silent> <nowait> [ :BufferPrevious<cr>
  nnoremap <silent> <nowait> ] :BufferNext<cr>
  nnoremap <silent> <nowait> { :BufferMovePrevious<cr>
  nnoremap <silent> <nowait> } :BufferMoveNext<cr>
]])


-- line, bar, tree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_cursor = true
lvim.builtin.nvimtree.setup.update_cwd = true
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = true
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
lvim.builtin.nvimtree.setup.view.mappings.list = {
  { key = {"<space>"}, cb = tree_cb("edit") },
  { key = {"<esc>"}, cb = tree_cb("close") },
}

lvim.builtin.lualine.options.theme = 'material-nvim'


-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent = { enable = true, disable = { "python", "yaml", "yml", "sql" } }

-- Additional Plugins
lvim.plugins = {
  { "marko-cerovac/material.nvim" },
  { "justinmk/vim-sneak" },
  { "tpope/vim-surround" },
  { "NikoKS/vim-iterm2-navigator", run = 'make install'},
  { "liuchengxu/vista.vim" },
  { "lukas-reineke/indent-blankline.nvim" }
  -- { "ntpeters/vim-better-whitespace" }
}

-- Additional settings for colorscheme
vim.g.material_style = "darker"
local material = require('material.colors')
lvim.transparent_window = true
require('material').setup({
	italics = {
		comments = true, -- Enable italic comments
	},
	custom_highlights = {-- Overwrite highlights with your own
    Sneak = { bg = 'none', fg = material.yellow },
    SneakScope = { fg = material.white, style = 'reverse'},
    NvimTreeEndOfBuffer = { fg= material.fg },
    NvimTreeFolderName = { fg = material.blue },
    NvimTreeFolderIcon = { fg = material.blue },
    NvimTreeOpenedFolderName = { fg = material.blue },
    NvimTreeGitDirty = { fg = material.yellow },
    BufferCurrent = { fg = material.green },
    BufferCurrentSign = { fg = material.green },
    BufferVisible = { bg = material.active },
    BufferVisibleSign = { bg = material.active, fg = material.green },
    BufferVisibleMod = { bg = material.active, fg = material.yellow },
    VertSplit = { fg = material.active, style = 'bold' }
  }
})


local actions = require("telescope.actions")
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
    -- ["p"] = actions.paste,
    ["w"] = function ()
      vim.cmd([[execute "normal! b"]])
    end,
    ["W"] = function ()
      vim.cmd([[execute "normal! B"]])
    end,
  }
}

-- Vim Sneak
vim.cmd([[
  let g:sneak#label = 1
  let g:sneak#use_ic_scs = 1
  let g:sneak#prompt = '🔎'
  let g:sneak#target_labels = 'fjewo;dkslqpurvncmzxbtySDFGHJKLZXCVBNMQWERTYUOP,./<>?:"[]{}\|1234567890-=!@#$%^&*()_+`~'
  nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
  nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
  xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
  xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
  onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
  onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
  map Q <Plug>Sneak_;
]])

-- vim surrond remmaping
vim.cmd([[
  nmap s ys
  nmap sw ysiw
  nmap sW ysiW
  vmap s S
]])

-- Auto Commands
lvim.autocommands.custom_groups = {
  { "WinEnter", "*", "setlocal cursorline" },
  { "WinLeave", "*", "if &ft !=# 'NvimTree' | setlocal nocursorline | endif" },
  { "TermLeave", "*", "if (winnr('$') == 1 && len(expand('%')) == 0) | nmap <buffer> <esc> :quit<cr>| endif" }
}

-- au BufEnter * if &ft ==# 'vimwiki'
--       \ | set winhl=Conceal:MyConceal
--       "\ | execute 'silent! CocDisable'
--       \ | endif
-- au BufLeave * if &ft ==# 'vimwiki'
--       \ | set winhl=Conceal:Conceal
--       "\ | execute 'silent! CocEnable'
--       \ | endif

-- Smart Enter
vim.cmd([[
  function! Smart_enter()
    let l:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    let l:fname = expand(expand('<cfile>'))
    if l:uri != ""
      silent exec "!open '".l:uri."'"
    elseif filereadable(l:fname)
      normal gf
    else
      normal gd
    endif
  endfunction
  nmap <silent> <CR> :call Smart_enter()<cr>
]])

-- visual-at.vim
vim.cmd([[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])

-- Vista
lvim.builtin.which_key.mappings["m"] = { ":Vista<cr>" , "Map"}
vim.g['vista_sidebar_width'] = 40
vim.g['vista_cursor_delay'] = 0

-- blankline
vim.g['indent_blankline_show_current_context'] = vim.v['true']
vim.g['indent_blankline_use_treesitter'] = true
vim.g['indent_blankline_show_first_indent_level'] = false
vim.g['indent_blankline_filetype_exclude'] = {'help', 'NvimTree', 'vista_kind', 'dashboard'}

-- vim terminal
lvim.builtin.terminal.float_opts.border = 'shadow'
lvim.builtin.terminal.float_opts.width = 200
lvim.builtin.terminal.float_opts.height = 100


-- Macros
-- vim.cmd([[
--   function! Smart_space()
--     if !v:hlsearch
--       normal @q
--     else
--       normal .
--     endif
--   endfunction
--   function Smart_cw()
--     if !v:hlsearch
--       normal ciw
--     else
--       normal cgn
--     endif
--   endfunction
--   nmap <silent> cw :call Smart_cw()<cr>
-- ]])

-- require'lspconfig'.sqlls.setup{
--   cmd = {"sql-language-server", "up", "--method", "stdio"};
--   ...
-- }
-- lvim.lang.sql.formatters = { { exe = "sql-formatter"}, args = { "-u" } }
