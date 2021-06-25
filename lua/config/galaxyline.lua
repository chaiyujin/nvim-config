local gl = require('galaxyline')
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default
local colors = {
    -- bg = '#2E2E2E',
    bg = '#292D38',
    yellow = '#DCDCAA',
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    green = '#608B4E',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C586C0',
    magenta = '#D16D9E',
    grey = '#858585',
    blue = '#569CD6',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    red = '#D16969',
    error_red = '#F44747',
    pink = '#FF79C6',
    info_yellow = '#FFCC66'
}
local condition = require('galaxyline.condition')
local gls = gl.section

local function wide_enough()
    local squeeze_width = vim.fn.winwidth(0)
    if squeeze_width > 80 then return true end
    return false
end

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}


--- Abbreviate each individual word in a string
-- @param s String to abbreviate
-- @param n Number of characters to abbreviate each word to
local abbrev = function(s, n)
    local result = ""
    for token in string.gmatch(s, "[^%s]+") do
        result = result .. string.sub(token, 1, n) .. " "
    end
    return result
end

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                        Left                                                        --
-- ------------------------------------------------------------------------------------------------------------------ --

local modes = {
    [ "n" ] = {colors.blue, "Normal", ""},
    [ "i" ] = {colors.green, "Insert", ""},
    [ "v" ] = {colors.pink, "Visual", ""},
    [""] = {colors.purple, "Visual Block", ""},
    [ "V" ] = {colors.purple, "Visual Line", ""},
    [ "c" ] = {colors.pink, "Command", ""},
    [ "no" ] = {colors.blue, "MODE", ""},
    [ "s" ] = {colors.orange, "MODE", ""},
    [ "S" ] = {colors.orange, "MODE", ""},
    [""] = {colors.orange, "MODE", ""},
    [ "ic" ] = {colors.yellow, "MODE", ""},
    [ "R" ] = {colors.red, "MODE", ""},
    [ "Rv" ] = {colors.red, "MODE", ""},
    [ "cv" ] = {colors.blue, "MODE", ""},
    [ "ce" ] = {colors.blue, "MODE", ""},
    [ "r" ] = {colors.cyan, "MODE", ""},
    [ "rm" ] = {colors.cyan, "MODE", ""},
    [ "r?" ] = {colors.cyan, "MODE", ""},
    [ "!" ] = {colors.blue, "MODE", ""},
    [ "t" ] = {colors.blue, "MODE", ""},
}

gls.left[1] = {
    ViMode = {
      provider = function()
        local mode = vim.fn.mode()
        local mode_color = modes[mode][1]
        local mode_string = modes[mode][2]
        local mode_icon = modes[mode][3]
        vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color .. ' guibg=' .. colors.bg .. ' gui=bold')
        return '▊ ' .. abbrev(mode_string, 2) .. ' '
      end,
    }
}
vim.fn.getbufvar(0, 'ts')

gls.left[2] = {
    GitIcon = {
      provider = function()
        return ' '
      end,
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.orange, colors.bg}
    }
}

gls.left[3] = {
    GitBranch = {
      provider = 'GitBranch',
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
}

gls.left[4] = {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.hide_in_width,
      icon = '  ',
      highlight = {colors.green, colors.bg}
    }
}

gls.left[5] = {
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.hide_in_width,
      icon = ' 柳',
      highlight = {colors.blue, colors.bg}
    }
}

gls.left[6] = {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.hide_in_width,
      icon = '  ',
      highlight = {colors.red, colors.bg}
    }
}

gls.left[7] = {
    FileName = {
      provider = function()
          -- terminal
          local bufname = vim.fn.bufname('%')
          if bufname:match("term://.*") then
              return 'terminal'
          end
          -- filename
          local fname
          if wide_enough() then
              fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
          else
              fname = vim.fn.expand '%:t'
          end
          if #fname == 0 then return '' end
          return ' ' .. fname .. ' '
      end,
      condition = condition.buffer_not_empty,
      highlight = {colors.grey, colors.bg}
    }
}

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                        Right                                                       --
-- ------------------------------------------------------------------------------------------------------------------ --

gls.right[1] = {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {colors.error_red, colors.bg}
    }
}

gls.right[2] = {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '  ',
      highlight = {colors.orange, colors.bg}
    }
}

gls.right[3] = {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = '  ',
      highlight = {colors.vivid_blue, colors.bg}
    }
}

gls.right[4] = {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {colors.info_yellow, colors.bg}
    }
}

gls.right[5] = {
    ShowLspClient = {
      provider = 'GetLspClient',
      condition = function()
          local tbl = {['dashboard'] = true, [' '] = true}
          if tbl[vim.bo.filetype] then return false end
          return true
      end,
      icon = '  ',
      highlight = {colors.grey, colors.bg}
    }
}

gls.right[6] = {
    LineInfo = {
      provider = 'LineColumn',
      separator = '  ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
}

gls.right[7] = {
    PerCent = {
      provider = 'LinePercent',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
}

gls.right[8] = {
    Tabstop = {
      provider = function()
          return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
      end,
      condition = condition.hide_in_width,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
}

gls.right[9] = {
    BufferType = {
      provider = 'FileTypeName',
      condition = condition.hide_in_width,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
}

gls.right[10] = {
    FileEncode = {
      provider = 'FileEncode',
      condition = condition.hide_in_width,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
}

gls.right[11] = {
    Space = {
      provider = function()
          return ' '
      end,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.orange, colors.bg}
    }
}

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                     Short line                                                     --
-- ------------------------------------------------------------------------------------------------------------------ --

gls.short_line_left[1] = {
    BufferType = {
      provider = 'FileTypeName',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
}

gls.short_line_left[2] = {
    SFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.grey, colors.bg}
    }
}

gls.short_line_right[3] = {
    BufferIcon = {
      provider = 'BufferIcon',
      highlight = {colors.grey, colors.bg}
    }
}
