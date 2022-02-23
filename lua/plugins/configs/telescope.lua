local utils = require('core.utils')
local cfg = utils.load_config()
local M = {}

M.setup = function()
   local opts = { noremap = true, silent = true }

   vim.api.nvim_set_keymap('n', '<leader>ff', ":Telescope find_files<CR>", opts)
   vim.api.nvim_set_keymap('n', '<leader>fg', ":Telescope live_grep <CR>", opts)
   vim.api.nvim_set_keymap('n', '<leader>fb', ":Telescope buffers   <CR>", opts)
   vim.api.nvim_set_keymap('n', '<leader>fh', ":Telescope help_tags <CR>", opts)
end

M.config = function()
   local default = {
      defaults = {
         -- Default configuration for telescope goes here:
         -- config_key = value,
         mappings = {
            i = {
               -- map actions.which_key to <C-h> (default: <C-/>)
               -- actions.which_key shows the mappings for your picker,
               -- e.g. git_{create, delete, ...}_branch for the git_branches picker
               ["<C-h>"] = "which_key"
            }
         }
      },
      pickers = {
         -- Default configuration for builtin pickers goes here:
         -- picker_name = {
         --   picker_config_key = value,
         --   ...
         -- }
         -- Now the picker_config_key will be applied every time you call this
         -- builtin picker
      },
      extensions = {
         -- Your extension configuration goes here:
         -- extension_name = {
         --   extension_config_key = value,
         -- }
         -- please take a look at the readme of the extension you want to configure
      }
   }

   require('telescope').setup(default)
end

return M
