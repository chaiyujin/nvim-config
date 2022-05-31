local M = {}
local prefix = ... .. "."
local folder = vim.fn.stdpath("config") .. "/lua/" .. (...):gsub("%.", "/")

-- Scan all *.lua in this folder, except 'init.lua'
local scandir = function(directory)
   local i, t, popen = 0, {}, io.popen
   local pfile = popen('ls "'..directory..'"')
   for filename in pfile:lines() do
      if filename ~= "init.lua" then
         filename = filename:gsub("%.lua", "")
         i = i + 1
         t[i] = filename
      end
   end
   pfile:close()
   return t
end

local names = scandir(folder)
for _, name in ipairs(names) do
   M[name] = require(prefix .. name)
end

-- Setup for each theme
M.setup_nord = function()
   local cfg = require('core.utils').load_config().ui.config.nord
   vim.g.nord_contrast                  = cfg.contrast
   vim.g.nord_borders                   = cfg.borders
   vim.g.nord_disable_background        = cfg.disable_background
   vim.g.nord_cursorline_transparent    = cfg.cursorline_transparent
   vim.g.nord_enable_sidebar_background = cfg.enable_sidebar_background
   vim.g.nord_italic                    = cfg.italic
   require("nord").set()
end

M.setup_github = function()
   local cfg = require('core.utils').load_config()
   require("github-theme").setup(cfg.ui.config.github)
end

M.setup_vscode = function()
   local cfg = require('core.utils').load_config().ui.config.vscode
   vim.g.vscode_style = cfg.style
   vim.g.vscode_transparent = cfg.transparent
   vim.g.vscode_italic_comment = cfg.italic_comment
   vim.g.vscode_disable_nvimtree_bg = cfg.disable_nvimtree_bg
   vim.cmd([[colorscheme vscode]])
end

M.setup_onedarkpro = function()
   local cfg = require('core.utils').load_config().ui.config.onedarkpro
   vim.o.background = cfg.background
   require('onedarkpro').load()
end

M.setup_xcode = function()
   vim.cmd([[colorscheme xcodedark]])
end

-- Final apply function, which chages some highlight groups.
M.apply = function(self)
   local cfg = require('core.utils').load_config()
   local use = cfg.ui.theme

   use = use:gsub("-", "_")
   self["setup_" .. use]()

   -- update highlight groups
   -- local colors = self[use]
   -- vim.cmd("hi StatusLine   gui=NONE guifg=" .. colors.nc    .. " guibg=" .. colors.nc)
   -- vim.cmd("hi StatusLineNC gui=NONE guifg=" .. colors.nc    .. " guibg=" .. colors.nc)
   -- vim.cmd("hi NormalNC     gui=NONE guifg=" .. colors.fg    .. " guibg=" .. colors.nc)
   -- vim.cmd("hi VertSplit    gui=NONE guifg=" .. colors.nc    .. " guibg=" .. colors.nc)
   -- vim.cmd("hi CursorLine   guibg=" .. colors.cursor)
   -- vim.cmd("hi CursorLineNr guibg=" .. colors.cursor)
   -- vim.cmd("hi SignColumn   guibg=NONE")
   -- vim.cmd("hi NvimTreeNormal     gui=NONE guifg=" .. colors.fg    .. " guibg=" .. colors.nc)
   -- vim.cmd("hi NvimTreeNormalNC   gui=NONE guifg=" .. colors.fg    .. " guibg=" .. colors.nc)
   -- vim.cmd("hi NvimTreeCursorLine gui=NONE guifg=NONE guibg=" .. vim.fn.synIDattr(vim.fn.hlID("NvimTreeIndentMarker"), "fg#", "gui"))
end

return M
