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
   signcolumn = "yes",
   mouse = "a",
   number = true,
   numberwidth = 2,
   relativenumber = false,
   expandtab = true,
   shiftwidth = 2,
   smartindent = true,
   tabstop = 8,
   timeoutlen = 400,
   updatetime = 250,
   undofile = true,
   fillchars = { eob = " " },
}

-- Load options for plugins
M.plugins = require("config.plugins")

-- Load optoins for mappings
M.mappings = require("config.mappings")

return M
