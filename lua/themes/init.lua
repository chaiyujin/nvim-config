local M = {}
local prefix = ... .. "."
local folder = vim.fn.stdpath("config") .. "/lua/" .. (...):gsub("%.", "/")

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

-- Scan all *.lua in this folder, except 'init.lua'
local names = scandir(folder)
for _, name in ipairs(names) do
   M[name] = require(prefix .. name)
end

-- Final apply function, which chages some highlight groups.
M.apply = function(self)
   local cfg = require('core.utils').load_config()
   local use = cfg.ui.theme
   local colors = self[use]

   vim.cmd("colorscheme "..cfg.ui.theme)
   -- update highlight groups
   vim.cmd("hi StatusLine   gui=NONE guifg=" .. colors.nc    .. " guibg=" .. colors.nc)
   vim.cmd("hi StatusLineNC gui=NONE guifg=" .. colors.nc    .. " guibg=" .. colors.nc)
   vim.cmd("hi NormalNC     gui=NONE guifg=" .. colors.fg    .. " guibg=" .. colors.nc)
   vim.cmd("hi VertSplit    gui=NONE guifg=" .. colors.nc    .. " guibg=" .. colors.nc)
   vim.cmd("hi CursorLine   guibg=" .. colors.cursor)
   vim.cmd("hi CursorLineNr guibg=" .. colors.cursor)
   vim.cmd("hi SignColumn   guibg=NONE")
   vim.cmd("hi NvimTreeNormal     gui=NONE guifg=" .. colors.fg    .. " guibg=" .. colors.nc)
   vim.cmd("hi NvimTreeNormalNC   gui=NONE guifg=" .. colors.fg    .. " guibg=" .. colors.nc)
   vim.cmd("hi NvimTreeCursorLine gui=NONE guifg=NONE guibg=" .. vim.fn.synIDattr(vim.fn.hlID("NvimTreeIndentMarker"), "fg#", "gui"))
end

return M
