-- Load user configuration
vim.cmd('luafile ' .. vim.fn.stdpath('config') .. '/config.lua')

-- Require lua settings
require('settings')
require('plugins')
require('keymaps')

-- TODO: rewrite in lua and move into 'lua' dir
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscripts/terminal.vim')

-- colorcheme
vim.cmd('colorscheme onedark')