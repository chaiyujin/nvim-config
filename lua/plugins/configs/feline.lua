local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local M = {}

local active_L = {}
local active_M = {}
local active_R = {}
local inactive_L = {}
local inactive_R = {}
local components = {
   active = { active_L, active_M, active_R },
   inactive = { inactive_L, inactive_R },
}

local themes = {
   nord = {
      fg = "#D8DEE9",
      bg = "#3B4252",
      bg_nc = "#2E3440",
      grey = "#616E88",
      white = "#ECEFF4",
      cyan = "#8FBCBB",
      cyan_bright = "#88C0D0",
      blue = "#81A1C1",
      blue_bright = "#5E81AC",
      red = "#BF616A",
      orange = "#D08770",
      yellow = "#EBCB8B",
      green = "#A3BE8C",
      magenta = "#B48EAD",
      violet = '#a9a1e1',
   },
}

local properties = {
   force_inactive = {
      filetypes = {
         'NvimTree',
         'dbui',
         'packer',
         'startify',
         'fugitive',
         'fugitiveblame'
      },
      buftypes = {'terminal'},
      bufnames = {}
   }
}

local vi_mode_colors = {
   NORMAL = 'blue',
   INSERT = 'green',
   VISUAL = 'cyan_bright',
   LINES = 'cyan_bright',
   BLOCK = 'cyan_bright',
   OP = 'magenta',
   REPLACE = 'violet',
   ['V-REPLACE'] = 'violet',
   ENTER = 'cyan',
   MORE = 'cyan',
   SELECT = 'orange',
   COMMAND = 'magenta',
   SHELL = 'blue',
   TERM = 'blue',
   NONE = 'bg'
}

local vi_mode_text = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    [''] = "V-BLOCK",
    V = "V-LINE",
    c = "COMMAND",
    no = "UNKNOWN",
    s = "UNKNOWN",
    S = "UNKNOWN",
    ic = "UNKNOWN",
    R = "REPLACE",
    Rv = "UNKNOWN",
    cv = "UNKWON",
    ce = "UNKNOWN",
    r = "REPLACE",
    rm = "UNKNOWN",
    t = "INSERT"
}

M.config = function()

   local compos = {
      vi_mode = {
         provider = function()
            local current_text = ' '..vi_mode_text[vim.fn.mode()]..' '
            return current_text
         end,
         hl = function()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                fg = vi_mode_utils.get_mode_color(),
                style = 'bold'
            }
         end,
         icon = {
            str = " ",
            hl = function()
               return {
                   name = vi_mode_utils.get_mode_highlight_name(),
                   fg = vi_mode_utils.get_mode_color(),
                   style = 'reverse'
               }
            end,
         },
      },

      git = {
         branch = {
            provider = 'git_branch',
            icon = ' ',
            hl = { fg = 'grey' }
         },
         add = {
            provider = 'git_diff_added',
            hl = { fg = 'green' }
         },
         change = {
            provider = 'git_diff_changed',
            hl = { fg = 'orange' }
         },
         remove = {
            provider = 'git_diff_removed',
            hl = { fg = 'red' }
        }
      },

      file = {
         info = {
            -- provider = 'file_info',
            provider = require("core.filename").get_current_ufn,
            icon = function()
               if vim.bo.modified then
                  return " "
               else
                  return " "
               end
            end,
            hl = {
                fg = 'white',
                style = 'bold'
            },
            left_sep = ' '
         },
         encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
               fg = 'cyan',
               style = 'bold'
            }
         },
         position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
               fg = 'green',
               -- style = 'bold'
            }
         },
      },

      diagnos = {
         err = {
            provider = 'diagnostic_errors',
            hl = { fg = 'red' }
         },
         warn = {
            provider = 'diagnostic_warnings',
            hl = { fg = 'yellow' }
         },
         hint = {
            provider = 'diagnostic_hints',
            hl = { fg = 'blue' }
         },
         info = {
            provider = 'diagnostic_info',
            hl = { fg = 'blue_bright' }
         },
      },

      lsp = {
         name = {
            provider = 'lsp_client_names',
            left_sep = ' ',
            icon = ' ',
            hl = { fg = 'grey' }
         }
      },

      line_percentage = {
         provider = 'line_percentage',
         left_sep = ' ',
         hl = { style = 'bold' }
      },

      scroll_bar = {
         provider = 'scroll_bar',
         left_sep = ' ',
         hl = { fg = 'blue_bright', style = 'bold' }
      },
   }

   local inactive_compos = {
      file = {
         info = {
            provider = function()
               local ft = vim.bo.filetype
               for _, invalid_ft in ipairs(properties.force_inactive.filetypes) do
                  if ft == invalid_ft then
                     return ""
                  end
               end
               return require("core.filename").get_current_ufn()
            end,
            icon = function()
               if vim.bo.modified then
                  return " "
               else
                  return " "
               end
            end,
            hl = {
                fg = 'white',
                bg = 'bg_nc'
            },
         },
      },
   }

   table.insert(active_L, compos.vi_mode)
   table.insert(active_L, compos.git.branch)
   table.insert(active_L, compos.git.add)
   table.insert(active_L, compos.git.change)
   table.insert(active_L, compos.git.remove)
   table.insert(active_L, compos.file.info)

   table.insert(active_R, compos.diagnos.info)
   table.insert(active_R, compos.diagnos.hint)
   table.insert(active_R, compos.diagnos.warn)
   table.insert(active_R, compos.diagnos.err)
   table.insert(active_R, compos.lsp.name)
   table.insert(active_R, compos.file.encoding)
   table.insert(active_R, compos.file.position)
   table.insert(active_R, compos.line_percentage)
   table.insert(active_R, compos.scroll_bar)

   table.insert(inactive_L, inactive_compos.file.info)

   require('feline').setup {
      colors = { fg = "bg_nc", bg = "bg_nc" },
      components = components,
      properties = properties,
      vi_mode_colors = vi_mode_colors
   }

   -- TODO: name of theme from config
   require('feline').add_theme('nord', themes.nord)
   require('feline').use_theme('nord')
   vim.cmd("hi StatusLine cterm=NONE guifg="..themes.nord.bg_nc.." guibg="..themes.nord.bg_nc)
end

return M
