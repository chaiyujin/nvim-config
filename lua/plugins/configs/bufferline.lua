local utils = require("core.utils")
local map_cfg = utils.load_config().mappings.buffer

local M = {}

M.setup = function()
   utils.map("n", map_cfg.next_buffer, ":BufferLineCycleNext <CR>")
   utils.map("n", map_cfg.prev_buffer, ":BufferLineCyclePrev <CR>")
   utils.map("n", map_cfg.move_next, ":BufferLineMoveNext <CR>")
   utils.map("n", map_cfg.move_prev, ":BufferLineMovePrev <CR>")
   -- Close buffer from utils
   utils.map("n", map_cfg.close_buffer, ":lua require('core.utils').close_buffer() <CR>")
end

M.config = function()
   local present, bufferline = pcall(require, "bufferline")
   if not present then
      return
   end

   -- local default = {
   --    colors = require("colors").get(),
   -- }

   local default = {
      options = {
         offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
         buffer_close_icon = "",
         modified_icon = "",
         close_icon = "",
         show_close_icon = false,
         left_trunc_marker = "",
         right_trunc_marker = "",
         max_name_length = 14,
         max_prefix_length = 13,
         tab_size = 20,
         show_tab_indicators = true,
         enforce_regular_tabs = false,
         view = "multiwindow",
         show_buffer_close_icons = true,
         separator_style = "thin",
         always_show_bufferline = true,
         diagnostics = false,
         custom_filter = function(buf_number)
            -- Func to filter out our managed/persistent split terms
            local present_type, type = pcall(function()
               return vim.api.nvim_buf_get_var(buf_number, "term_type")
            end)

            if present_type then
               if type == "vert" then
                  return false
               elseif type == "hori" then
                  return false
               end
               return true
            end

            return true
         end,
      },

      -- highlights = {
      --    background = {
      --       guifg = default.colors.grey_fg,
      --       guibg = default.colors.black2,
      --    },

      --    -- buffers
      --    buffer_selected = {
      --       guifg = default.colors.white,
      --       guibg = default.colors.black,
      --       gui = "bold",
      --    },
      --    buffer_visible = {
      --       guifg = default.colors.light_grey,
      --       guibg = default.colors.black2,
      --    },

      --    -- for diagnostics = "nvim_lsp"
      --    error = {
      --       guifg = default.colors.light_grey,
      --       guibg = default.colors.black2,
      --    },
      --    error_diagnostic = {
      --       guifg = default.colors.light_grey,
      --       guibg = default.colors.black2,
      --    },

      --    -- close buttons
      --    close_button = {
      --       guifg = default.colors.light_grey,
      --       guibg = default.colors.black2,
      --    },
      --    close_button_visible = {
      --       guifg = default.colors.light_grey,
      --       guibg = default.colors.black2,
      --    },
      --    close_button_selected = {
      --       guifg = default.colors.red,
      --       guibg = default.colors.black,
      --    },
      --    fill = {
      --       guifg = default.colors.grey_fg,
      --       guibg = default.colors.black2,
      --    },
      --    indicator_selected = {
      --       guifg = default.colors.black,
      --       guibg = default.colors.black,
      --    },

      --    -- modified
      --    modified = {
      --       guifg = default.colors.red,
      --       guibg = default.colors.black2,
      --    },
      --    modified_visible = {
      --       guifg = default.colors.red,
      --       guibg = default.colors.black2,
      --    },
      --    modified_selected = {
      --       guifg = default.colors.green,
      --       guibg = default.colors.black,
      --    },

      --    -- separators
      --    separator = {
      --       guifg = default.colors.black2,
      --       guibg = default.colors.black2,
      --    },
      --    separator_visible = {
      --       guifg = default.colors.black2,
      --       guibg = default.colors.black2,
      --    },
      --    separator_selected = {
      --       guifg = default.colors.black2,
      --       guibg = default.colors.black2,
      --    },

      --    -- tabs
      --    tab = {
      --       guifg = default.colors.light_grey,
      --       guibg = default.colors.one_bg3,
      --    },
      --    tab_selected = {
      --       guifg = default.colors.black2,
      --       guibg = default.colors.nord_blue,
      --    },
      --    tab_close = {
      --       guifg = default.colors.red,
      --       guibg = default.colors.black,
      --    },
      -- },
   }

   bufferline.setup(default)
end

return M
