-- plugins
require('plugins')

-- Load default and user configuration, must be after plugins,
-- otherwise, O will be overwrite
require('defaults')

require('common')
require('keymaps')
require('colorscheme')

-- config lsp servers
require("lang.python")
require("lang.clangd")

