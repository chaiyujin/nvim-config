local M = {}

M.mapleader = " "

-- Options for vim.opt
M.opt = {
   clipboard = "unnamedplus",
   cmdheight = 1,
   wrap = false,
   ruler = false,
   hidden = true,
   ignorecase = true,
   smartcase = true,
   showmode = false,
   signcolumn = "yes",
   mouse = "a",
   number = true,
   numberwidth = 2,
   relativenumber = true,
   expandtab = true,
   shiftwidth = 2,
   smartindent = true,
   tabstop = 8,
   timeoutlen = 400,
   updatetime = 250,
   undofile = true,
   fillchars = { eob = " " },
   cursorline = true,
   termguicolors = true,
   guifont = 'SF Mono:h10',
}

-- Options for UI
M.ui = {
   theme = "github",

   config = {
      nord = {
         contrast = true,
         borders = false,
         disable_background = false,
         cursorline_transparent = false,
         enable_sidebar_background = false,
         italic = false,
      },
      github = {
         theme_style = "light",
         function_style = "italic",
         sidebars = {"qf", "vista_kind", "terminal", "packer"},
         -- Change the "hint" color to the "orange" color, and make the "error" color bright red
         colors = {hint = "orange", error = "#ff0000"},
         -- Overwrite the highlight groups
         overrides = function(c)
            return {
               htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
                DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
               -- this will remove the highlight groups
               TSField = {},
            }
         end,
		},
	},
}

-- Load options for plugins
M.plugins = require("config.plugins")

-- Load optoins for mappings
M.mappings = require("config.mappings")

return M
