local utils = require("core.utils")
local cfg = utils.load_config()
local M = {}

M.setup = function()
   vim.g.mapleader = cfg.mapleader
   for k, v in pairs(cfg.opt) do
      vim.opt[k] = v
   end
end

return M
