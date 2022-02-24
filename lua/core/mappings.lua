local utils = require("core.utils")
local cfg = utils.load_config()
local map = utils.map
local m = cfg.mappings

local M = {}

M.setup = function()
   -- Window Navigation
   map('n', m.window_nav.move_left,  '<C-w>h')
   map('n', m.window_nav.move_right, '<C-w>l')
   map('n', m.window_nav.move_down,  '<C-w>j')
   map('n', m.window_nav.move_up,    '<C-w>k')
   map('i', m.window_nav.move_left,  '<C-\\><C-n><C-w>h')
   map('i', m.window_nav.move_right, '<C-\\><C-n><C-w>l')
   map('i', m.window_nav.move_down,  '<C-\\><C-n><C-w>j')
   map('i', m.window_nav.move_up,    '<C-\\><C-n><C-w>k')
   map('t', m.window_nav.move_left,  '<C-\\><C-n><C-w>h')
   map('t', m.window_nav.move_right, '<C-\\><C-n><C-w>l')
   map('t', m.window_nav.move_down,  '<C-\\><C-n><C-w>j')
   map('t', m.window_nav.move_up,    '<C-\\><C-n><C-w>k')
   map('t', '<Esc>', '<C-\\><C-n>')

   -- Resize window with arrows
   map('n', m.window_resize.inc_height, ':resize +2<CR>')
   map('n', m.window_resize.dec_height, ':resize -2<CR>')
   map('n', m.window_resize.inc_width,  ':vertical resize +2<CR>')
   map('n', m.window_resize.dec_width,  ':vertical resize -2<CR>')
   map('t', m.window_resize.inc_height, '<C-\\><C-n>:resize +2<CR>')
   map('t', m.window_resize.dec_height, '<C-\\><C-n>:resize -2<CR>')
   map('t', m.window_resize.inc_width,  '<C-\\><C-n>:vertical resize +2<CR>')
   map('t', m.window_resize.dec_width,  '<C-\\><C-n>:vertical resize -2<CR>')
   
   -- Indenting without de-selection
   map('v', '<', '<gv')
   map('v', '>', '>gv')

   -- Move selected line / block of text in visual mode
   -- map('x', 'K', ':move \'<-2<CR>gv-gv')
   -- map('x', 'J', ':move \'>+1<CR>gv-gv')

   -- Highlight
   map('n', '<Leader>h', ':set hlsearch!<CR>')
end

return M
