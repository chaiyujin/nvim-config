local cfg = require("core.utils").load_config()
local M = {}

M.default_plugins = {
   "nvim-lua/plenary.nvim",
   "nvim-tree/nvim-web-devicons",

   -- UI components.
   require("plugin.detail.nvim_tree"),  -- file explorer
   require("plugin.detail.floaterm"),  -- terminal
   require("plugin.detail.lualine"), -- statusline
   require("plugin.detail.barbar"),
   -- TODO: "utilyre/barbecue.nvim",  -- winbar
   -- TODO: bufferline: https://github.com/rafcamlet/tabline-framework.nvim, https://github.com/johann2357/nvim-smartbufs

   -- Git diffview.
   require("plugin.detail.diffview"),

   -- Auto Session.
   require("plugin.detail.misc").auto_session,

   -- Decorations.
   require("plugin.detail.todo_comments"),
   require("plugin.detail.misc").comment,
   require("plugin.detail.misc").colorizer,
   require("plugin.detail.misc").indent_blankline,
   require("plugin.detail.misc").gitsigns,
   require("plugin.detail.misc").tint,

   -- LSP.
   require("plugin.lang.mason"),
   require("plugin.lang.lspconfig"),
   require("plugin.lang.mason-lspconfig"),
   require("plugin.lang.treesitter"),
   require("plugin.lang.cmp"),
   require("plugin.lang.misc").fidget,
   require("plugin.lang.misc").neodim,  -- dim unsed
   require("plugin.lang.misc").illuminate,  -- highlight hovering words

   -- Others.
   -- TODO: 'nvim-telescope/telescope.nvim',
   -- TODO: "max397574/better-escape.nvim",
   -- TODO: 'windwp/nvim-spectre', -- Provide vscode-like workspace search and replacement.
}

-- Themes
table.insert(M.default_plugins, require("plugin.theme." .. cfg.theme.using))

return M
