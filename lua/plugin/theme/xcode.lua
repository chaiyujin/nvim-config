local M = {
   'lunacookies/vim-colors-xcode',
   lazy = false, -- make sure we load this during startup if it is your main colorscheme
   priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function(_, _)
   local cfg = require('core.utils').load_config().theme.xcode
   vim.cmd("set termguicolors")
   vim.cmd("colorscheme " .. cfg.style)
end

return M
