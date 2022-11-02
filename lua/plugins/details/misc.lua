local utils = require("core.utils")
local cfg = utils.load_config()
local M = {}

M.better_escape = function()
   require("better_escape").setup {
      mapping = cfg.mappings.better_escape.esc_insertmode,
      timeout = cfg.plugins.better_escape.esc_insertmode_timeout,
   }
end

M.indent_blankline = function()
   local default = {
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
   }
   require("indent_blankline").setup(default)
end

M.gitsigns = function()
   local gitsigns = require("gitsigns")
   local default = {
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
   }
   gitsigns.setup(default)
end

M.luasnip = function()
   local luasnip = require("luasnip")
   local default = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
   }
   luasnip.config.set_config(default)
   require("luasnip.loaders.from_vscode").load()
end


M.nvim_autopairs = function()
   local autopairs = require("nvim-autopairs")
   local cmp_autopairs = require("nvim-autopairs.completion.cmp")

   local default = { fast_wrap = {} }
   autopairs.setup(default)

   local cmp = require "cmp"
   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.lsp_signature = function()
   local lspsignature = require("lsp_signature")
   local default = {
      bind = true,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hint_prefix = " ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
         border = "single", -- double, single, shadow, none
      },
      zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
      padding = " ", -- character to pad on left and right of signature can be ' ', or '|'  etc
   }
   lspsignature.setup(default)
end

M.colorizer = function()
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
   vim.cmd "ColorizerReloadAllBuffers"
end

return M
