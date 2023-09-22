local M = {
   "projekt0n/github-nvim-theme",
   lazy = false, -- make sure we load this during startup if it is your main colorscheme
   priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function(_, _)
   local cfg = require('core.utils').load_config().theme.github
   -- Default options:
   require("github-theme").setup(cfg)
   vim.cmd("colorscheme github_" .. cfg.style)
end

return M

