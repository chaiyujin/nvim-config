local M = {
   'luisiacc/gruvbox-baby',
   lazy = false, -- make sure we load this during startup if it is your main colorscheme
   priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function(_, _)
   local cfg = require('core.utils').load_config().theme.gruvbox
   -- Example config in Lua
   vim.g.gruvbox_baby_function_style = cfg.function_style
   vim.g.gruvbox_baby_keyword_style = cfg.keyword_style

   -- Each highlight group must follow the structure:
   -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
   -- See also :h highlight-guifg
   -- Example:
   -- vim.g.gruvbox_baby_highlights = {Normal = {fg = "#123123", bg = "NONE", style="underline"}}

   -- Enable telescope theme
   vim.g.gruvbox_baby_telescope_theme = cfg.telescope_theme

   -- Enable transparent mode
   vim.g.gruvbox_baby_transparent_mode = cfg.transparent_mode
   -- load the colorscheme here
   vim.cmd([[colorscheme gruvbox-baby]])
end

return M
