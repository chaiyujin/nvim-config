local M = {}

M.fidget = {
   "j-hui/fidget.nvim",
   event = "LspAttach",
   opts = {
      text = {
         spinner = "dots",
      }
   },
   config = function(_, opts)
      require("fidget").setup(opts)
   end
}

M.neodim = {
   "zbirenbaum/neodim",
   event = "LspAttach",
   opts = {
      alpha = 0.75,
      blend_color = "#000000",
      update_in_insert = {
         enable = false,
         delay = 100,
      },
      hide = {
         virtual_text = true,
         signs = true,
         underline = true,
      }
   },
   config = function(_, opts)
      require("neodim").setup(opts)
   end,
}

M.illuminate = {
   "RRethy/vim-illuminate",
   event = "LspAttach",
   opts = {
      providers = { 'lsp', 'treesitter', 'regex' },
      delay = 100,  -- delay in milliseconds
      filetypes_denylist = { 'dirvish', 'fugitive', 'floaterm', 'NvimTree' },
      modes_denylist = { 'i', 'ic', 'ix', 't' },
      min_count_to_highlight = 2,  -- minimum number of matches required to perform highlighting
   },
   config = function(_, opts)
      require("illuminate").configure(opts)
   end,
}

return M
