vim.cmd [[set termguicolors]]

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()
require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Status line
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup{
        options = {
          theme = 'material',
          section_separators = {'', ''},
          component_separators = {'', ''},
          icons_enabled = true,
        },
        sections = {
          lualine_a = { {'mode', upper = true} },
          lualine_b = { {'branch', icon = ''} },
          lualine_c = { {'filename', file_status = true} },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location'  },
        },
        inactive_sections = {
          lualine_a = {  },
          lualine_b = {  },
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {  },
          lualine_z = {   }
        },
        extensions = { 'fzf' }
      }
    end
  }

  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('bufferline').setup{
        options = {
          view = "default", -- "multiwindow" | "default"
          numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both",
          number_style = "", -- | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
          mappings = false,
          buffer_close_icon= '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is deduplicated
          tab_size = 18,
          diagnostics = "nvim_lsp",  -- false | "nvim_lsp"
          diagnostics_indicator = function(count, level, diagnostics_dict)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          show_buffer_close_icons = true, -- | false,
          show_close_icon = true, -- | false,
          show_tab_indicators = true, -- | false,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          -- can also be a table containing 2 custom separators
          -- [focused and unfocused]. eg: { '|', '|' }
          separator_style = "slant",  -- "slant" | "thick" | "thin" | { 'any', 'any' },
          enforce_regular_tabs = false,  -- | true,
          always_show_bufferline = true,  -- | false,
          sort_by = function(buffer_a, buffer_b)
            -- add custom logic
            if (buffer_a.modified == buffer_b.modified)
            then
              return buffer_a.id < buffer_b.id
            else
              return buffer_a.modified > buffer_b.modified
            end
          end
        }
      }
    end
  }

end)

