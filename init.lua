-- plugins
require('plugins')

-- load default and user configuration, must be after plugins
require('defaults')
-- user configuration is 'config.lua' side by this file.
vim.cmd('luafile ' .. vim.fn.stdpath('config') .. '/config.lua')
-- common settings
require('common')
-- key mappings
require('keymaps')
-- colorscheme
require('colorscheme')

-- TODO: rewrite in lua and move into 'lua' dir
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscripts/terminal.vim')