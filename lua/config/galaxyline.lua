local gl = require('galaxyline')
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default

-- # Palette
-- white       : '#E6E6E6'
-- black       : '#292A2B'
-- black_dark  : '#232425'
-- black_light : '#31353A'
-- black_vivid : '#42404C'
-- grey        : '#BBBBBB'
-- grey_dark   : '#757575'
-- grey_darker : '#676B79'
-- green       : '#81B88B'
-- green_light : '#B5EBC8'
-- cyan        : '#35FFDC'
-- pink        : '#FF90D0'
-- pink_light  : '#FF9AC1'
-- red         : '#EC2864'
-- red_error   : '#FF4B82'
-- yellow      : '#FFCC95'  # '#FFB86C',
-- blue        : '#7DC1FF'  # '#6FC1FF'
-- blue_grey   : '#62679A'
-- purple      : '#B084EB'

local colors = {
    bg = '#31353A',
    bg_nc = '#232425',
    grey = '#BBBBBB',
    grey_darker = '#676B79',
    yellow = '#FFCC95',
    purple = '#B084EB',
    cyan = '#19f9d8',
    green = '#81B88B',
    green_light = '#B5EBC8',
    pink = '#FF9AC1',
    blue = '#7DC1FF',
    red = '#EC2864',
    error_red = '#FF4B82',
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
    [ "i" ] = {colors.green_light, "Insert", ""},
    [ "v" ] = {colors.pink, "Visual", ""},
    [""] = {colors.pink, "Visual Block", ""},
    [ "V" ] = {colors.pink, "Visual Line", ""},
    [ "c" ] = {colors.green_light, "Command", ""},
    [ "no" ] = {colors.blue, "MODE", ""},
    [ "s" ] = {colors.purple, "MODE", ""},
    [ "S" ] = {colors.purple, "MODE", ""},
    [""] = {colors.purple, "MODE", ""},
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
        return '▊ ' .. mode_string .. ' '
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
      highlight = {colors.pink, colors.bg}
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
      highlight = {colors.yellow, colors.bg}
    }
}

gls.right[3] = {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = '  ',
      highlight = {colors.blue, colors.bg}
    }
}

gls.right[4] = {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {colors.green, colors.bg}
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
      highlight = {colors.purple, colors.bg}
    }
}

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                     Short line                                                     --
-- ------------------------------------------------------------------------------------------------------------------ --

gls.short_line_left[1] = {
    SFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.grey_darker, colors.bg_nc}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
      provider = 'BufferIcon',
      highlight = {colors.grey_darker, colors.bg_nc}
    }
}

