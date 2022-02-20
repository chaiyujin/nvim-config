local M = {}

M.setup = function()
   -- Better window movement
   local utils = require("core.utils")
   local map = utils.map
   local cfg = utils.load_config()
   local m = cfg.mappings
   map('n', m.window_nav.move_left,  '<C-w>h')
   map('n', m.window_nav.move_right, '<C-w>l')
   map('n', m.window_nav.move_down,  '<C-w>j')
   map('n', m.window_nav.move_up,    '<C-w>k')
   map('i', m.window_nav.move_left,  '<C-\\><C-N><C-w>h')
   map('i', m.window_nav.move_right, '<C-\\><C-N><C-w>l')
   map('i', m.window_nav.move_down,  '<C-\\><C-N><C-w>j')
   map('i', m.window_nav.move_up,    '<C-\\><C-N><C-w>k')
   map('t', m.window_nav.move_left,  '<C-\\><C-N><C-w>h')
   map('t', m.window_nav.move_right, '<C-\\><C-N><C-w>l')
   map('t', m.window_nav.move_down,  '<C-\\><C-N><C-w>j')
   map('t', m.window_nav.move_up,    '<C-\\><C-N><C-w>k')
   map('t', '<Esc>', '<C-\\><C-n>')
   
   -- Indenting without de-selection
   map('v', '<', '<gv')
   map('v', '>', '>gv')
   -- Highlight
   map('n', '<Leader>h', ':set hlsearch!<CR>')
end

return M
