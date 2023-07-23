local M = {
   'rose-pine/neovim',
   name = 'rose-pine',
   lazy = false, -- make sure we load this during startup if it is your main colorscheme
   priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function(_, _)
   local cfg = require('core.utils').load_config()["theme"]["rose-pine"]
   require('rose-pine').setup(cfg)
   vim.cmd('colorscheme rose-pine')
end

return M
