return {
   -- Some basic plugins for UI and neovim per se.
   "nvim-lua/plenary.nvim",
   "nvim-tree/nvim-web-devicons",
   "folke/neodev.nvim",  -- for neovim lua development.

   -- lsp config.
   {
      "mason-org/mason-lspconfig.nvim",
      opts = {
         ensure_installed = { "lua_ls", "vimls", "pyright" },
         automatic_enable = { "lua_ls", "vimls", "pyright" },
      },
      dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
      },
   }
}
