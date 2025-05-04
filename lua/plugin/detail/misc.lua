local M = {}

M.auto_session = {
   'rmagatti/auto-session',
   lazy = false,
   config = function()
      require('auto-session').setup {
         log_level = 'error',
         auto_session_suppress_dirs = {'~/', '~/Documents/', '~/Projects/', '/'}, 
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

M.indentscope = {
   'echasnovski/mini.indentscope',
   version = false,
   event = "BufRead",
   config = function()
      require("mini.indentscope").setup({
         -- Draw options
         draw = {
            -- Delay (in ms) between event and start of drawing scope indicator
            delay = 50,

            -- Animation rule for scope's first drawing. A function which, given
            -- next and total step numbers, returns wait time (in ms). See
            -- |MiniIndentscope.gen_animation| for builtin options. To disable
            -- animation, use `require('mini.indentscope').gen_animation.none()`.
            -- animation = --<function: implements constant 20ms between steps>,
            animation = require('mini.indentscope').gen_animation.none(),

            -- Symbol priority. Increase to display on top of more symbols.
            priority = 2,
         },

         -- Module mappings. Use `''` (empty string) to disable one.
         -- mappings = {
         --    -- Textobjects
         --    object_scope = 'ii',
         --    object_scope_with_border = 'ai',

         --    -- Motions (jump to respective border line; if not present - body line)
         --    goto_top = '[i',
         --    goto_bottom = ']i',
         -- },

         -- Options which control scope computation
         options = {
            -- Type of scope's border: which line(s) with smaller indent to
            -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
            border = 'none',

            -- Whether to use cursor column when computing reference indent.
            -- Useful to see incremental scopes with horizontal cursor movements.
            indent_at_cursor = true,

            -- Whether to first check input line to be a border of adjacent scope.
            -- Use it if you want to place cursor on function header to get scope of
            -- its body.
            try_as_border = false,
         },

         -- Which character to use for drawing scope indicator
         symbol = '╎',
      })
   end
}

M.gitsigns = {
   "lewis6991/gitsigns.nvim",
   event = "BufRead",
   dependencies = { "plenary.nvim" },
   opts = {
      signs = {
         add          = { text = '┃' },
         change       = { text = '┃' },
         delete       = { text = '_' },
         topdelete    = { text = '‾' },
         changedelete = { text = '~' },
         untracked    = { text = '┆' },
      },
      signs_staged = {
         add          = { text = '┃' },
         change       = { text = '┃' },
         delete       = { text = '_' },
         topdelete    = { text = '‾' },
         changedelete = { text = '~' },
         untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
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
   },
   config = function(_, opts)
      require("gitsigns").setup(opts)
   end
}

M.tint = {
   "levouh/tint.nvim",
   -- dependencies = {"barbecue"},  -- After barbecue so that it can tint winbar.
   lazy = false,
   opts = {
      tint = -10,  -- Darken colors, use a positive value to brighten
      saturation = 1.0,  -- Saturation to preserve
      tint_background_colors = true,  -- Tint background portions of highlight groups
      highlight_ignore_patterns = { "WinSeparator", "Status.*" },  -- Highlight group patterns to ignore, see `string.find`
      window_ignore_function = function(winid)
         local bufid = vim.api.nvim_win_get_buf(winid)
         local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
         local filetype = vim.api.nvim_buf_get_option(bufid, "ft")
         local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
         -- Do not tint `terminal` or floating windows, tint everything else
         return buftype == "terminal" or filetype == "NvimTree" or floating
      end
   },
   config = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
         transforms = require("tint").transforms.SATURATE_TINT,  -- Showing default behavior, but value here can be predefined set of transforms
      })
      require("tint").setup(opts)
   end
}

M.barbecue = {
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

M.vim_tmux_navigator = {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<C-h>",  ":TmuxNavigateLeft<cr>" },
    { "<C-j>",  ":TmuxNavigateDown<cr>" },
    { "<C-k>",  ":TmuxNavigateUp<cr>" },
    { "<C-l>",  ":TmuxNavigateRight<cr>" },
    { "<C-\\>", ":TmuxNavigatePrevious<cr>" },
  },
}

M.vim_tpipeline = {
   "vimpostor/vim-tpipeline",
   config = function(_, _)
      vim.g.tpipeline_autoembed = 1
      vim.g.tpipeline_restore = 1
      vim.g.tpipeline_clearstl = 1
   end
}

return M
