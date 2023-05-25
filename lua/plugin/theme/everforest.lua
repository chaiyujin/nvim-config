local M = {
   "neanias/everforest-nvim",
   lazy = false, -- make sure we load this during startup if it is your main colorscheme
   priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function()
   local cfg = require('core.utils').load_config().theme.everforest
   vim.o.background = cfg.style
   require("everforest").setup(cfg)
   require("everforest").load()
end

return M
