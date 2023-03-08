return {
   theme = "dracula",

   config = {
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
         disable_background = false,
         cursorline_transparent = false,
         enable_sidebar_background = false,
         italic = false,
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
            background = false, -- Disable setting the background color
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
         style = "light",
         background = "medium",
         better_performance = 1,
      },
	},
}
