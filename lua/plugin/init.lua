local cfg = require("core.utils").load_config()
local M = {}

M.default_plugins = {
   "nvim-lua/plenary.nvim",
   "nvim-tree/nvim-web-devicons",
   "folke/neodev.nvim",  -- for neovim lua development.

   -- UI components.
   require("plugin.detail.nvim_tree"),  -- file explorer
   require("plugin.detail.floaterm"),  -- terminal
   require("plugin.detail.lualine"), -- statusline
   require("plugin.detail.barbar"),
   -- require("plugin.detail.luatab"),
   -- require("plugin.detail.smartbufs"),
   require("plugin.detail.misc").barbecue,  -- winbar
   -- TODO: bufferline: https://github.com/rafcamlet/tabline-framework.nvim, https://github.com/johann2357/nvim-smartbufs

   -- Git diffview.
   require("plugin.detail.diffview"),

   -- Auto Session.
   require("plugin.detail.misc").auto_session,

   -- Decorations.
   require("plugin.detail.todo_comments"),
   require("plugin.detail.misc").comment,
   require("plugin.detail.misc").colorizer,
   -- require("plugin.detail.misc").indent_blankline,
   require("plugin.detail.misc").indentscope,
   require("plugin.detail.misc").gitsigns,
   require("plugin.detail.misc").tint,

   -- LSP.
   require("plugin.lang.mason"),
   require("plugin.lang.lspconfig"),
   require("plugin.lang.mason-lspconfig"),
   require("plugin.lang.treesitter"),
   require("plugin.lang.cmp"),
   -- require("plugin.lang.misc").fidget,
   -- require("plugin.lang.misc").neodim,  -- WARNING: currently need nvim0.10.0
   require("plugin.lang.misc").illuminate,  -- highlight hovering words

   -- Others.
   -- TODO: 'nvim-telescope/telescope.nvim',
   -- TODO: "max397574/better-escape.nvim",
   -- TODO: 'windwp/nvim-spectre', -- Provide vscode-like workspace search and replacement.

   require("plugin.detail.noice"),
   require("plugin.detail.vimtex"),
   require("plugin.detail.misc").vim_tmux_navigator,
   require("plugin.detail.misc").vim_tpipeline,
}

-- Themes
table.insert(M.default_plugins, require("plugin.theme." .. cfg.theme.using))

return M
