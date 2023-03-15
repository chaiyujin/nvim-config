local M = {}

M.auto_session = {
   'rmagatti/auto-session',
   lazy = false,
   config = function()
      require('auto-session').setup {
         log_level = 'error',
         auto_session_suppress_dirs = {'~/', '~/Documents/', '~/Projects/' }
      }
   end
}

M.comment = {
   'numToStr/Comment.nvim',
   lazy = false,
   config = function()
      require('Comment').setup()
   end
}

M.colorizer = {
   "norcalli/nvim-colorizer.lua",
   cmd = "ColorizerToggle",
   config = function()
      local colorizer = require("colorizer")
      local default = {
         filetypes = {
            "*",
         },
         user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = false, -- "Name" codes like Blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

            -- Available modes: foreground, background
            mode = "background", -- Set the display mode.
         },
      }
      colorizer.setup(default["filetypes"], default["user_default_options"])
      vim.cmd[[ColorizerReloadAllBuffers]]
   end
}

M.indent_blankline = {
   "lukas-reineke/indent-blankline.nvim",
   event = "BufRead",
   opts = {
      indentLine_enabled = 1,
      char = "▏",
      filetype_exclude = {
         "help",
         "terminal",
         "alpha",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
         "nvchad_cheatsheet",
         "lsp-installer",
         "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
   },
   config = function(_, opts)
      require("indent_blankline").setup(opts)
   end
}

M.gitsigns = {
   "lewis6991/gitsigns.nvim",
   event = "BufRead",
   dependencies = { "plenary.nvim" },
   opts = {
      signs = {
         add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
         change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
         delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
         topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
         changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
         interval = 1000,
         follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
         virt_text = true,
         virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
         delay = 1000,
         ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
         -- Options passed to nvim_open_win
         border = 'single',
         style = 'minimal',
         relative = 'cursor',
         row = 0,
         col = 1
      },
      yadm = {
         enable = false
      },
   },
   config = function(_, opts)
      require("gitsigns").setup(opts)
   end
}

return M