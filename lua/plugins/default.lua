local M = {
   -- Basic assets

   { "nvim-lua/plenary.nvim" },
   { "kyazdani42/nvim-web-devicons" },

   -- File related

   {
      "kyazdani42/nvim-tree.lua",
      opt    = true,
      cmd    = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
      after  = "nvim-web-devicons",
      config = function() require("plugins.configs.nvim_tree").config() end,
      setup  = function() require("plugins.configs.nvim_tree").setup() end,
   },

   -- UI, Color things

   { "shaunsingh/nord.nvim" },

   {
      "akinsho/bufferline.nvim",
      after  = "nvim-web-devicons",
      config = function() require("plugins.configs.bufferline").config() end,
      setup  = function() require("plugins.configs.bufferline").setup() end,
   },

   {
      "feline-nvim/feline.nvim",
      after  = "nvim-web-devicons",
      config = function() require("plugins.configs.feline").config() end,
   },

   {
      "voldikss/vim-floaterm",
      setup  = function() require("plugins.configs.floaterm").setup()  end,
      config = function() require("plugins.configs.floaterm").config() end,
   },

   {
      "lukas-reineke/indent-blankline.nvim",
      event  = "BufRead",
      config = function() require("plugins.configs.misc").indent_blankline() end,
   },

   {
      "lewis6991/gitsigns.nvim",
      after  = "plenary.nvim",
      config = function() require("plugins.configs.misc").gitsigns() end,
   },

   {
      "NvChad/nvim-colorizer.lua",
      event  = "BufRead",
      config = function() require("plugins.configs.misc").colorizer() end,
   },

   -- Improvement

   {
      "max397574/better-escape.nvim",
      event  = "InsertCharPre",
      config = function() require("plugins.configs.misc").better_escape() end,
   },

   {
      'numToStr/Comment.nvim',
      config = function() require('Comment').setup() end
   },

   {
      "nvim-treesitter/nvim-treesitter",
      event  = "BufRead",
      config = function() require("plugins.configs.nvim_treesitter").config() end,
   },

   {
      "folke/todo-comments.nvim",
      after  = "plenary.nvim",
      event  = "BufRead",
      config = function() require("plugins.configs.todo_comments").config() end,
   },

   {
      "ur4ltz/surround.nvim", 
      config = function() require"surround".setup {mappings_style = "surround"} end
   },

   {
      "sindrets/diffview.nvim",
      config = function() require("plugins.configs.diffview").config() end
   },

   {
      "folke/which-key.nvim",
      config = function() require("plugins.configs.which_key").config() end
   },

   -- LSP

   {
      "neovim/nvim-lspconfig",
      config = function() require("plugins.configs.nvim_lspconfig").config() end,
   },

   {
      "hrsh7th/nvim-cmp",
      after  = "nvim-lspconfig",
      config = function() require("plugins.configs.nvim_cmp").config() end,
      requires = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
      },
   },
   { "L3MON4D3/LuaSnip", after  = "nvim-cmp", config = function() require("plugins.configs.misc").luasnip() end },
   { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },

   {
      "williamboman/nvim-lsp-installer",
      after = "nvim-cmp",
      config = function() require("plugins.configs.nvim_lsp_installer").config() end,
   },

   {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function() require("plugins.configs.misc").nvim_autopairs() end,
   },

   {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function() require("plugins.configs.misc").lsp_signature() end,
   },
}

return M
