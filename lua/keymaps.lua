-- Change leader to <Space>
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

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

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Indenting without de-selection
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- no highlight
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- ------------------------------------------------------------------------------------------------------------------ --
--                                                 Keymaps for Plugins                                                --
-- ------------------------------------------------------------------------------------------------------------------ --

-- nvim-tree
vim.api.nvim_set_keymap('n', '<A-e>',   ":lua require'file-explorer'.toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-e>',   "<Esc>:lua require'file-explorer'.toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<A-e>',   "<C-\\><C-n>:lua require'file-explorer'.toggle()<CR>", { noremap = true, silent = true })

-- barbar: Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>',   ':BufferNext<CR>',     { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-x>',   ':BufferClose<CR>',    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-.>',   ':BufferNext<CR>',     { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-,>',   ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-q>',   ':BufferClose<CR>',    { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-.>',   '<Esc>:BufferNext<CR>',     { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-,>',   '<Esc>:BufferPrevious<CR>', { noremap = true, silent = true })

-- CommentToggle, besides gc/gcc
vim.api.nvim_set_keymap('n', '<Leader>k', ':CommentToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<Leader>k', ':CommentToggle<CR>', {noremap = true, silent = true})

-- completion-nvim: Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap('i', '<Tab>',   'pumvisible() ? "\\<C-n>" : "\\<Tab>"',   {noremap = true, expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {noremap = true, expr = true})

-- Floaterm
vim.api.nvim_set_keymap('n', '<C-j>',     ':FloatermToggle<CR>',            { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-j>',     '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

-- Dashboard
vim.api.nvim_set_keymap('n', '<Leader>ss',     ':<C-u>SessionSave<CR>', { noremap = false, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>sl',     ':<C-u>SessionLoad<CR>', { noremap = false, silent = false })
-- nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
-- nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
-- nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
-- nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
-- nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
-- nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

