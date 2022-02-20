local M = {
   {
      "kyazdani42/nvim-tree.lua", opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
      requires = { 'kyazdani42/nvim-web-devicons' },  -- optional, for file icon 
      config = function() require("plugins.configs.nvim_tree").config() end,
      setup = function() require("plugins.configs.nvim_tree").setup() end,
   },
}

return M
