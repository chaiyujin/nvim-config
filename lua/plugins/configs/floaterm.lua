local utils = require('core.utils')
local map_cfg = utils.load_config().mappings
local M = {}

M.setup = function()
   utils.map('n', map_cfg.floaterm.toggle, ':FloatermToggle<CR>')
   utils.map('t', map_cfg.floaterm.toggle, '<C-\\><C-n>:FloatermToggle<CR>')
end

M.config = function()
   vim.g.floaterm_wintype  = 'split'
   vim.g.floaterm_position = 'botright'
   vim.g.floaterm_height   = 0.3
   vim.cmd[[autocmd TermOpen  * setlocal nonumber norelativenumber signcolumn=no nocul]]
   vim.cmd[[autocmd TermEnter * setlocal nonumber norelativenumber signcolumn=no nocul]]
end

return M
