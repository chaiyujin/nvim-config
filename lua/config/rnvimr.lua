-- Make Ranger replace netrw and be the file explorer
vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_enable_bw = 1
vim.g.rnvimr_draw_border = 1
vim.cmd('highlight link RnvimrNormal CursorLine')
vim.api.nvim_set_keymap('n', '<A-o>', ':RnvimrToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-o>', '<C-\\><C-n>:RnvimrToggle<CR>', {noremap = true, silent = true})
vim.g.rnvimr_action = {}
vim.g.rnvimr_action['<CR>'] = 'NvimEdit drop'
-- vim.cmd([[let g:rnvimr_action = {
--   \ '<C-t>': 'NvimEdit tabedit',
--   \ '<C-x>': 'NvimEdit split',
--   \ '<C-v>': 'NvimEdit vsplit',
--   \ 'gw': 'JumpNvimCwd',
--   \ 'yw': 'EmitRangerCwd'
--   \ }]])