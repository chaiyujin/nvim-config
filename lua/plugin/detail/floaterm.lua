local M = {
   "voldikss/vim-floaterm",
   cmd = { "FloatermToggle", "FloatermNew" },
}

M.init = function()
   local utils = require('core.utils')
   local map_cfg = utils.load_config().mapping
   utils.map('n', map_cfg.floaterm.toggle, ':FloatermToggle<CR>')
   utils.map('t', map_cfg.floaterm.toggle, '<C-\\><C-n>:FloatermToggle<CR>')
   vim.cmd[[autocmd TermOpen  * setlocal nonumber norelativenumber signcolumn=no nocul winbar=]]
   vim.cmd[[autocmd TermEnter * setlocal nonumber norelativenumber signcolumn=no nocul]]
end

M.config = function()
   -- vim.g.floaterm_wintype  = 'float'
   -- vim.g.floaterm_position = 'botright'
   -- vim.g.floaterm_height   = 0.3
   vim.g.floaterm_wintype = 'float'
   vim.g.floaterm_height  = 0.8
   vim.g.floaterm_width   = 0.8
   -- vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
   -- vim.g.floaterm_borderchars = '━┃━┃┏┓┛┗'
   vim.g.floaterm_borderchars = '═║═║╔╗╝╚'

   vim.cmd[[hi FloatermBorder guibg=#00000000 guifg=pink]]
end

return M
