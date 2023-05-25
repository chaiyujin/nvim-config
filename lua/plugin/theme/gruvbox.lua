local M = {
   "ellisonleao/gruvbox.nvim",
   lazy = false, -- make sure we load this during startup if it is your main colorscheme
   priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function(_, _)
   local cfg = require('core.utils').load_config().theme.gruvbox
   -- Default options:
   require("gruvbox").setup(cfg)
   vim.cmd("colorscheme gruvbox")
end

return M

