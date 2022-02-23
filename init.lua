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
vim.cmd("colorscheme "..cfg.ui.theme)
-- update highlight groups
local themes = require('core.themes')
local colors = themes[cfg.ui.theme]
vim.cmd("hi Cursor       gui=NONE guifg=" .. colors.white .. " guibg=" .. colors.blue_bright)
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
