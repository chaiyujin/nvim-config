-- ------------------------------------------------------------------------------------------------------------------ --
--                                                  Essential Plugins                                                 --
-- ------------------------------------------------------------------------------------------------------------------ --
local M = {
   -- Basic plugins for many others.
   { "nvim-lua/plenary.nvim" },
   { "kyazdani42/nvim-web-devicons" },

   -- File explorer.
   {
      "kyazdani42/nvim-tree.lua",
      opt    = true,
      cmd    = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
      after  = "nvim-web-devicons",
      config = function() require("plugins.details.nvim_tree").config() end,
      setup  = function() require("plugins.details.nvim_tree").setup() end,
   },

   -- Colorschemes.
   { "Mofiqul/vscode.nvim" },
   { "Mofiqul/dracula.nvim" },
   { "shaunsingh/nord.nvim" },
   -- { "projekt0n/github-nvim-theme" },
   -- { "olimorris/onedarkpro.nvim" },
   -- { "arzg/vim-colors-xcode" },
   -- { "sainnhe/everforest" },
   -- { "rose-pine/neovim", as = 'rose_pine', tag = 'v1.*' },
}

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                     Improvement                                                    --
-- ------------------------------------------------------------------------------------------------------------------ --

-- Better UI for coding.
table.insert(M, {
   "lewis6991/gitsigns.nvim",
   after = "plenary.nvim",
   config = function() require("plugins.details.misc").gitsigns() end
})

table.insert(M, {
   "lukas-reineke/indent-blankline.nvim",
   event = "BufRead",
   config = function() require("plugins.details.misc").indent_blankline() end
})

table.insert(M, {
   "norcalli/nvim-colorizer.lua",
   cmd = "ColorizerToggle",
   config = function() require("plugins.details.misc").colorizer() end
})

table.insert(M, {
   "folke/todo-comments.nvim",
   after = "plenary.nvim",
   event = "BufRead",
   config = function() require("plugins.details.todo_comments").config() end
})

-- Comment.
table.insert(M, {
   'numToStr/Comment.nvim',
   config = function() require('Comment').setup() end
})

-- Bufferline.
table.insert(M, {
   "akinsho/bufferline.nvim",
   after  = { "nvim-web-devicons" },
   config = function() require("plugins.details.bufferline").config() end,
   setup  = function() require("plugins.details.bufferline").setup() end,
})

-- Statusline.
table.insert(M, {
   "feline-nvim/feline.nvim",
   after  = "nvim-web-devicons",
   config = function() require("plugins.details.feline").config() end,
})

-- table.insert(M, {
--    'nvim-lualine/lualine.nvim',
--    config = function() require("plugins.details.lualine").config() end,
-- })

-- Winbar.
table.insert(M, {
   "fgheng/winbar.nvim",
   config = function() require("plugins.details.winbar").config() end
})

-- Embedded terminal.
table.insert(M, {
   "voldikss/vim-floaterm",
   opt    = true,
   cmd    = { "FloatermToggle", "FloatermNew" },
   setup  = function() require("plugins.details.floaterm").setup()  end,
   config = function() require("plugins.details.floaterm").config() end,
})

-- Git difference.
table.insert(M, {
   "sindrets/diffview.nvim",
   cmd = "DiffviewOpen",
   setup = function() require("plugins.details.diffview").setup() end,
   config = function() require("plugins.details.diffview").config() end
})

-- Auto Session.
table.insert(M, {
   'rmagatti/auto-session',
   config = function()
      require('auto-session').setup {
         log_level = 'error',
         auto_session_suppress_dirs = {'~/', '~/Documents/', '~/Documents/Projects/' }
      }
   end
})

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                     TreeSitter                                                     --
-- ------------------------------------------------------------------------------------------------------------------ --

table.insert(M, {
   "nvim-treesitter/nvim-treesitter",
   event = "BufRead",
   config = function() require("plugins.details.nvim_treesitter").config() end
})

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                         LSP                                                        --
-- ------------------------------------------------------------------------------------------------------------------ --

table.insert(M, {
   "neovim/nvim-lspconfig",
   config = function() require("plugins.details.nvim_lspconfig").config() end,
})

table.insert(M, {
   "hrsh7th/nvim-cmp",
   after  = "nvim-lspconfig",
   config = function() require("plugins.details.nvim_cmp").config() end,
   requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
   },
})

table.insert(M, {
   "L3MON4D3/LuaSnip",
   after  = "nvim-cmp",
   config = function() require("plugins.details.misc").luasnip() end
})

table.insert(M, {
   "saadparwaiz1/cmp_luasnip",
   after = "LuaSnip"
})

table.insert(M, {
   "williamboman/nvim-lsp-installer",
   after = "nvim-cmp",
   config = function() require("plugins.details.nvim_lsp_installer").config() end,
})

table.insert(M, {
   "windwp/nvim-autopairs",
   after = "nvim-cmp",
   config = function() require("plugins.details.misc").nvim_autopairs() end,
})

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                  Optional plugins                                                  --
-- ------------------------------------------------------------------------------------------------------------------ --

-- table.insert(M, {
--    'nvim-telescope/telescope.nvim',
--    opt    = true,
--    cmd    = { "Telescope" },
--    after  = { 'plenary.nvim'},
--    setup  = function() require("plugins.details.telescope").setup()  end,
--    config = function() require("plugins.details.telescope").config() end
-- })

-- table.insert(M, {
--    "max397574/better-escape.nvim",
--    event = "InsertCharPre",
--    config = function() require("plugins.details.misc").better_escape() end
-- })

-- table.insert(M, {
--    -- Provide vscode-like workspace search and replacement
--    'windwp/nvim-spectre',
--    config = function() require('spectre').setup() end
-- })

return M
