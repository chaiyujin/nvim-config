local utils = require("core.utils")
local cfg = utils.load_config()
local map_cfg = cfg.mappings.buffer

local M = {}

M.setup = function()
   utils.map("n", map_cfg.next_buffer, ":BufferLineCycleNext <CR>")
   utils.map("n", map_cfg.prev_buffer, ":BufferLineCyclePrev <CR>")
   utils.map("i", map_cfg.next_buffer, "<C-\\><C-n>:BufferLineCycleNext <CR>")
   utils.map("i", map_cfg.prev_buffer, "<C-\\><C-n>:BufferLineCyclePrev <CR>")
   utils.map("n", map_cfg.move_next,   ":BufferLineMoveNext <CR>")
   utils.map("n", map_cfg.move_prev,   ":BufferLineMovePrev <CR>")
   -- Close buffer from utils
   utils.map("n", map_cfg.close_buffer, ":lua require('core.utils').close_buffer() <CR>")
end

M.config = function()
   local present, bufferline = pcall(require, "bufferline")
   if not present then
      return
   end

   local themes = require("themes")

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
         show_buffer_close_icons = false,
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
   }

   bufferline.setup(default)
end

return M
