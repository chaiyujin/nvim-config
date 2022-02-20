vim.opt.cmdheight = 3

-- basic settings
local utils = require("core.utils")
local cfg = utils.load_config()
vim.mapleader = cfg.mapleader
for k, v in pairs(cfg.opt) do
   vim.opt[k] = v
end

-- load packer
require("plugins")

-- mappings
require("core.mappings").setup()

-- colorscheme
vim.cmd[[colorscheme nord]]
