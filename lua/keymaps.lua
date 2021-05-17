-- Better window movement
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-h>', '<C-\\><C-N><C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<C-\\><C-N><C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<C-\\><C-N><C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-l>', '<C-\\><C-N><C-w>l', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-N><C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-N><C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-N><C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-N><C-w>l', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

-- resize with arrows
vim.api.nvim_set_keymap('n', '<C-Up>',    ':resize +2<CR>',          {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>',  ':resize -2<CR>',          {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>',  ':vertical resize -2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-Up>',    '<C-\\><C-n>:resize +2<CR>',          {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-Down>',  '<C-\\><C-n>:resize -2<CR>',          {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-Left>',  '<C-\\><C-n>:vertical resize -2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-Right>', '<C-\\><C-n>:vertical resize +2<CR>', {noremap = true, silent = true})

-- nvim-tree
vim.api.nvim_set_keymap('n', '<A-e>',   ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- barbar: Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>',   ':BufferNext<CR>',     { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-x>',   ':BufferClose<CR>',    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-=>',   ':BufferNext<CR>',     {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-->',   ':BufferPrevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-q>',   ':BufferClose<CR>',    {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})