local utils = require("core.utils")
local map_cfg = utils.load_config().mappings
local M = {}

M.setup = function()
   utils.map('n', map_cfg.floaterm.toggle, ':Ttoggle<CR>')
   utils.map('t', map_cfg.floaterm.toggle, '<C-\\><C-n>:Ttoggle<CR>')
   vim.cmd[[autocmd TermOpen  * setlocal nonumber norelativenumber signcolumn=no nocul hidden]]
   vim.cmd[[autocmd TermEnter * setlocal nonumber norelativenumber signcolumn=no nocul]]
end

M.config = function()
   require("termwrapper").setup {
      -- these are all of the defaults
      open_autoinsert = true, -- autoinsert when opening
      toggle_autoinsert = true, -- autoinsert when toggling
      autoclose = true, -- autoclose, (no [Process exited 0])
      winenter_autoinsert = false, -- autoinsert when entering the window
      default_window_command = "belowright 13split", -- the default window command to run when none is specified,
                                                     -- opens a window in the bottom
      open_new_toggle = true, -- open a new terminal if the toggle target does not exist
      log = 1, -- 1 = warning, 2 = info, 3 = debug
   }
end

return M
