local M = {
   { "kyazdani42/nvim-web-devicons" },

   {
      "kyazdani42/nvim-tree.lua", opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
      after = "nvim-web-devicons",
      config = function() require("plugins.configs.nvim_tree").config() end,
      setup = function() require("plugins.configs.nvim_tree").setup() end,
   },

   {
      "akinsho/bufferline.nvim",
      after = "nvim-web-devicons",
      config = function() require("plugins.configs.bufferline").config() end,
      setup = function() require("plugins.configs.bufferline").setup() end,
   },

   -- UI, Color things
   { "shaunsingh/nord.nvim" },

   -- Improvement
   {
      "max397574/better-escape.nvim",
      event = "InsertCharPre",
      config = function() require("plugins.configs.misc").better_escape() end,
   },

}

return M
