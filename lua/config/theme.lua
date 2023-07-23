return {
   using = "everforest",

   vscode = {
      style = "dark",
      transparent = true,
      italic_comments = true,
      disable_nvimtree_bg = false,
   },
   dracula = {
      show_end_of_buffer = false,
      transparent_bg = true,
      italic_comment = true,
      lualine_bg_color = nil,
   },
   nord = {
      style = "dark",
      contrast = false,
      borders = true,
      disable_background = true,
      cursorline_transparent = false,
      enable_sidebar_background = false,
      italic = false,
      bold = false,
   },
   onenord = {
      theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
      borders = true, -- Split window borders
      fade_nc = false, -- Fade non-current windows, making them more distinguishable
      -- Style that is applied to various groups: see `highlight-args` for options
      styles = {
         comments = "NONE",
         strings = "NONE",
         keywords = "NONE",
         functions = "NONE",
         variables = "NONE",
         diagnostics = "underline",
      },
      disable = {
         background = true, -- Disable setting the background color
         cursorline = false, -- Disable the cursorline
         eob_lines = true, -- Hide the end-of-buffer lines
      },
      -- Inverse highlight for different groups
      inverse = {
         match_paren = false,
      },
      custom_highlights = {}, -- Overwrite default highlight groups
      custom_colors = {}, -- Overwrite default colors
   },
   github = {
      theme_style = "light",
      comment_style = "italic",
      keyword_style = "NONE",
      function_style = "bold",
      variable_style = "NONE",
      sidebars = {"qf", "vista_kind", "terminal", "packer"},
      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      -- colors = {hint = "orange", error = "#ff0000"},
      -- Overwrite the highlight groups
      overrides = function(c)
         return {
            htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
               DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
            -- this will remove the highlight groups
            TSField = {},
         }
      end,
   },
   everforest = {
      -- light or dark.
      style = "dark",
      -- Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
      background = "medium",
      -- How much of the background should be transparent. Options are 0, 1 or 2.
      -- 2 will have more UI components be transparent (e.g. status line background).
      transparent_background_level = 1,
      -- Whether italics should be used for keywords, builtin types and more.
      italics = false,
      -- Disable italic fonts for comments. Comments are in italics by default, set
      -- this to `true` to make them _not_ italic!
      disable_italic_comments = false,
   },
   gruvbox_baby = {
      function_style = "NONE",
      keyword_style = "italic",
      telescope_theme = 1,
      transparent_mode = 1,
   },
   gruvbox = {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
         strings = false,
         comments = true,
         operators = false,
         folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "soft", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
   },
   xcode = {
      style = "xcodelight",
   },
   ["rose-pine"] = {
      variant = "dawn",
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      disable_italics = false,
      highlight_groups = {
         ["@variable"] = { italic = false },
         ["@property"] = { italic = false },
         StatusLine = { fg = "love", bg = "love", blend = 10 },
         StatusLineNC = { fg = "subtle", bg = "surface" },
      },
   },
}
