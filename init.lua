-- plugins
require('plugins')

-- Load default and user configuration, must be after plugins,
-- otherwise, O will be overwrite
require('defaults')
-- user configuration is 'config.lua' side by this file.
vim.cmd('luafile ' .. vim.fn.stdpath('config') .. '/config.lua')

require('common')
require('keymaps')
require('colorscheme')
