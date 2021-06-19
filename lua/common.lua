vim.cmd('filetype plugin indent on')
vim.cmd('set shortmess+=c')  -- " Avoid showing message extra message when using completion
vim.o.syntax = 'on'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.virtualedit = "block"
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.o.updatetime = O.updatetime  -- faster completion
vim.o.timeoutlen = O.timeoutlen  -- enough time for key sequence
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.o.cmdheight = O.cmdheight
vim.o.pumheight = O.pumheight
vim.o.guifont = O.guifont

vim.wo.wrap = false -- always in one line
vim.wo.number = true -- set numbered lines
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.relativenumber = true -- set relative number