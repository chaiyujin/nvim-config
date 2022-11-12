if vim.g.neovide then
   -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
   vim.g.neovide_transparency = 0.0
   vim.g.transparency = 0.9
   vim.g.neovide_background_color = '#282A36DD'

   -- Allow clipboard copy paste in neovim.
   vim.g.neovide_input_use_logo = 1
   vim.api.nvim_set_keymap('',  '<D-v>', '+p<CR>', { noremap = true, silent = true})
   vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
   vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
   vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

   -- Interprets Alt + whatever actually as <M-whatever>, instead of sending the actual special character to Neovim.
   vim.g.neovide_input_macos_alt_is_meta = true
end

require("core.opt").setup()
require("core.mappings").setup()
require("plugins")
require("themes"):apply()
