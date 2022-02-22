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

return M
