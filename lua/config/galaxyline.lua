local gl = require('galaxyline')

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
local buffer = require('galaxyline.provider_buffer')
local fileinfo = require('galaxyline.provider_fileinfo')
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
  [ "n" ] = {colors.blue, "N ", ""},
  [ "i" ] = {colors.green_light, "I ", ""},
  [ "v" ] = {colors.pink, "V ", ""},
  [""] = {colors.pink, "VB", ""},
  [ "V" ] = {colors.pink, "VL", ""},
  [ "c" ] = {colors.green_light, "C ", ""},
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

vim.fn.getbufvar(0, 'ts')

gls.left = {
  {
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
  },
  {
    GitIcon = {
      provider = function()
        return ' '
      end,
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.pink, colors.bg}
    }
  },
  {
    GitBranch = {
      provider = 'GitBranch',
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
  },
  {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.hide_in_width,
      icon = '  ',
      highlight = {colors.green, colors.bg}
    }
  },
  {
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.hide_in_width,
      icon = ' 柳',
      highlight = {colors.blue, colors.bg}
    }
  },
  {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.hide_in_width,
      icon = '  ',
      highlight = {colors.red, colors.bg}
    }
  },
  {
    FileName = {
      provider = function()
        -- terminal
        local bufname = vim.fn.bufname('%')
        if bufname:match("term://.*") then
          return 'terminal'
        end
        -- filename
        local fname
        if condition.hide_in_width() then
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
  },
}

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                        Right                                                       --
-- ------------------------------------------------------------------------------------------------------------------ --

gls.right = {
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {colors.error_red, colors.bg}
    }
  },
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '  ',
      highlight = {colors.yellow, colors.bg}
    }
  },
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = '  ',
      highlight = {colors.blue, colors.bg}
    }
  },
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {colors.green, colors.bg}
    }
  },
  {
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
  },
  {
    Percent = {
      provider = function()
        local mode = vim.fn.mode()
        local mode_color = modes[mode][1]
        vim.api.nvim_command('hi GalaxyPercent guifg=' .. colors.bg .. ' guibg=' .. mode_color)
        return fileinfo.current_line_percent()
      end,
      separator = ' ',
      separator_highlight = {colors.grey, colors.bg},
    }
  },
  {
    LineInfo = {
      provider = function()
        local mode = vim.fn.mode()
        local mode_color = modes[mode][1]
        vim.api.nvim_command('hi GalaxyLineInfo guifg=' .. colors.bg .. ' guibg=' .. mode_color)
        return fileinfo.line_column()
      end,
    }
  },
  {
    FileEncode = {
      provider = function()
        local mode = vim.fn.mode()
        local mode_color = modes[mode][1]
        vim.api.nvim_command('hi GalaxyFileEncode guifg=' .. colors.bg .. ' guibg=' .. mode_color)
        return fileinfo.get_file_encode()
      end,
      condition = condition.hide_in_width,
    }
  },
  {
    Space = {
      provider = function()
        local mode = vim.fn.mode()
        local mode_color = modes[mode][1]
        vim.api.nvim_command('hi GalaxySpace guifg=' .. mode_color .. ' guibg=' .. mode_color)
        return ' '
      end,
    }
  },
}

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                     Short line                                                     --
-- ------------------------------------------------------------------------------------------------------------------ --

gls.short_line_left = {
  {
    BufferType = {
      provider = function()
        return '▊ ' .. buffer.get_buffer_filetype()
      end,
      condition = condition.buffer_not_empty,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg_nc},
      highlight = {colors.grey_darker, colors.bg_nc}
    }
  },
  {
    SFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.grey_darker, colors.bg_nc}
    }
  },
}

gls.short_line_right = {
  {
    BufferIcon = {
      provider = 'BufferIcon',
      highlight = {colors.grey_darker, colors.bg_nc}
    }
  },
}

