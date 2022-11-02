local M = {}

M.config = function()
   require('winbar').setup({
      enabled = true,

      show_file_path = true,
      show_symbols = true,

      colors = {
         path = '#6272a4', -- You can customize colors like #c946fd
         file_name = '#8be9fd',
         symbols = '',
      },

      icons = {
         file_icon_default = '',
         seperator = '/',
         editor_state = '●',
         lock_icon = '',
      },

      exclude_filetype = {
         'help',
         'startify',
         'dashboard',
         'packer',
         'neogitstatus',
         'NvimTree',
         'Trouble',
         'alpha',
         'lir',
         'Outline',
         'spectre_panel',
         'toggleterm',
         'floaterm',
         'term',
         'qf',
      }
   })
end

return M
