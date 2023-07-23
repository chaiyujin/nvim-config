local M = {}

-- Options for vim, vim.opt
M.mapleader = " "
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
   guifont = 'Liga SFMono Nerd Font:h18:#e-subpixelantialias:#h-none',
   laststatus = 3,  -- global statusline
   statusline = "  %f %m %= %l:%c   ",
   showtabline = 2,
}

-- Load optoins for mappings
M.mapping = require("config.mapping")

-- Options for themes.
M.theme = require("config.theme")

-- Options for plugin
M.plugin = require("config.plugin")

return M
