local M = {
   "neanias/everforest-nvim",
   lazy = false, -- make sure we load this during startup if it is your main colorscheme
   priority = 1000, -- make sure to load this before all the other start plugins
}

M.opts = {
   -- light or dark.
   style = "dark",
   -- Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
   background = "medium",
   -- How much of the background should be transparent. Options are 0, 1 or 2.
   -- 2 will have more UI components be transparent (e.g. status line background).
   transparent_background_level = 1,
   -- Whether italics should be used for keywords, builtin types and more.
   italics = false,
   -- Disable italic fonts for comments. Comments are in italics by default, set
   -- this to `true` to make them _not_ italic!
   disable_italic_comments = false,
}

M.config = function(_, opts)
   vim.o.background = opts.style
   require("everforest").setup(opts)
   require("everforest").load()
end

return M
