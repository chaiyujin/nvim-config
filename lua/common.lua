vim.cmd([[
filetype plugin indent on
]])

vim.o.syntax = 'on'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.virtualedit = "block"
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.cmdheight = 2
vim.o.writebackup = false -- This is recommended by coc
vim.o.updatetime = 300  -- faster completion
vim.o.timeoutlen = 1000  -- enough time (1000ms) for key sequence
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.o.t_Co = "256"
vim.wo.wrap = false -- always in one line
vim.wo.number = true -- set numbered lines
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.relativenumber = true -- set relative number