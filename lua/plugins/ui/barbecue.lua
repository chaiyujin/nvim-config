return {
   "utilyre/barbecue.nvim",
   name = "barbecue",
   lazy = false,
   version = "*",
   event = "BufRead",
   dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
   },
   opts = {
      create_autocmd = true,
   },
   config = function(_, opts)
      require("barbecue").setup(opts)
   end
}
