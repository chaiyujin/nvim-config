return {
   using = "everforest",

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
   dracula = {
      show_end_of_buffer = false,
      transparent_bg = true,
      italic_comment = true,
      lualine_bg_color = nil,
   },
   vscode = {
      style = "dark",
      transparent = true,
      italic_comments = true,
      disable_nvimtree_bg = false,
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
      style = "dark_tritanopia",
      options = {
         -- Compiled file's destination location
         compile_path = vim.fn.stdpath('cache') .. '/github-theme',
         compile_file_suffix = '_compiled', -- Compiled file suffix
         hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
         hide_nc_statusline = true, -- Override the underline style for non-active statuslines
         transparent = true,       -- Disable setting background
         terminal_colors = true,    -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
         dim_inactive = false,      -- Non focused panes set to alternative background
         module_default = true,     -- Default enable value for modules
         styles = {                 -- Style to be applied to different syntax groups
            comments = 'NONE',       -- Value is any valid attr-list value `:help attr-list`
            functions = 'NONE',
            keywords = 'NONE',
            variables = 'NONE',
            conditionals = 'NONE',
            constants = 'NONE',
            numbers = 'NONE',
            operators = 'NONE',
            strings = 'NONE',
            types = 'NONE',
         },
         inverse = {                -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
         },
         darken = {                 -- Darken floating windows and sidebar-like windows
            floats = false,
            sidebars = {
               enable = true,
               list = {},             -- Apply dark background to specific windows
            },
         },
         modules = {},                -- List of various plugins and additional options
      },
      palettes = {},
      specs = {},
      groups = {},
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
      transparent_mode = true,
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
         ["@parameter"] = { italic = false },
         ["@method"] = { italic = false },
         StatusLine = { fg = "love", bg = "love", blend = 10 },
         StatusLineNC = { fg = "subtle", bg = "surface" },
         TabLine = { fg = "love", bg = "love", blend = 10 },
         TabLineSel = { fg = "subtle", bg = "background" },
         TabLineFill = { fg = "love", bg = "love", blend = 10 },
      },
   },
   kanagawa = {
      compile = false,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true},
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,         -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
         palette = {},
         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
         return {}
      end,
      theme = "wave",              -- Load "wave" theme
      background = {               -- map the value of 'background' option to a theme
         dark = "wave",           -- try "dragon" !
         light = "lotus"
      },
   },
}
