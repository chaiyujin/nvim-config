local utils = require("core.utils")
local cfg = utils.load_config()
local map_cfg = cfg.mapping.buffer

local M = {
   'romgrk/barbar.nvim',
   lazy = false,
   dependencies = { "nvim-web-devicons" },
}

M.init = function()
   utils.map("n", map_cfg.next_buffer,  ":BufferNext <CR>")
   utils.map("n", map_cfg.prev_buffer,  ":BufferPrevious <CR>")
   utils.map("i", map_cfg.next_buffer,  "<C-\\><C-n>:BufferNext <CR>")
   utils.map("i", map_cfg.prev_buffer,  "<C-\\><C-n>:BufferPrevious <CR>")
   utils.map("n", map_cfg.move_next,    ":BufferMoveNext <CR>")
   utils.map("n", map_cfg.move_prev,    ":BufferMovePrevious <CR>")
   utils.map("n", map_cfg.close_buffer, ":BufferClose<CR>")
   utils.map("n", map_cfg.pick_buffer,  ":BufferPick<CR>")
end

M.opts = {
   -- Enable/disable animations
   animation = false,

   -- Enable/disable auto-hiding the tab bar when there is a single buffer
   auto_hide = false,

   -- Enable/disable current/total tabpages indicator (top right corner)
   tabpages = true,

   -- Enable/disable close button
   closable = true,

   -- Enables/disable clickable tabs
   --  - left-click: go to buffer
   --  - middle-click: delete buffer
   clickable = false,

   -- Excludes buffers from the tabline
   exclude_ft = {'javascript', 'terminal'},
   exclude_name = {'package.json'},

   -- Show every buffer
   hide = {current = false, inactive = false, visible = false},

   icons = {
      -- Configure the base icons on the bufferline.
      buffer_index = false,
      buffer_number = false,
      button = '',
      -- Enables / disables diagnostic symbols
      diagnostics = {
         [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
         [vim.diagnostic.severity.WARN] = {enabled = false},
         [vim.diagnostic.severity.INFO] = {enabled = false},
         [vim.diagnostic.severity.HINT] = {enabled = false},
      },
      filetype = {
         -- Sets the icon's highlight group.
         -- If false, will use nvim-web-devicons colors
         custom_colors = false,

         -- Requires `nvim-web-devicons` if `true`
         enabled = true,
      },
      separator = {left = '▎', right = ''},

      -- Configure the icons on the bufferline when modified or pinned.
      -- Supports all the base icon options.
      modified = {button = '●'},
      pinned = {button = '車'},

      -- Configure the icons on the bufferline based on the visibility of a buffer.
      -- Supports all the base icon options, plus `modified` and `pinned`.
      alternate = {filetype = {enabled = false}},
      current = {buffer_index = true},
      inactive = {button = '×'},
      visible = {modified = {buffer_number = false}},
   },

   -- If true, new buffers will be inserted at the start/end of the list.
   -- Default is to insert after current buffer.
   insert_at_end = false,
   insert_at_start = false,

   -- Sets the maximum padding width with which to surround each tab
   maximum_padding = 1,

   -- Sets the minimum padding width with which to surround each tab
   minimum_padding = 1,

   -- Sets the maximum buffer name length.
   maximum_length = 30,

   -- If set, the letters for each buffer in buffer-pick mode will be
   -- assigned based on their name. Otherwise or in case all letters are
   -- already assigned, the behavior is to assign letters in order of
   -- usability (see order below)
   semantic_letters = true,

   -- New buffer letters are assigned in this order. This order is
   -- optimal for the qwerty keyboard layout but might need adjustement
   -- for other layouts.
   letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

   -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
   -- where X is the buffer number. But only a static string is accepted here.
   no_name_title = nil,
}

M.config = function(_, opts)
   require("bufferline").setup(opts)
end

return M
