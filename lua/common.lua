vim.cmd('filetype plugin indent on')
vim.cmd('set shortmess+=c')  -- " Avoid showing message extra message when using completion
vim.o.syntax = 'on'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.cursorline = true
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
vim.o.conceallevel = 0

vim.wo.wrap = false -- always in one line
vim.wo.number = true -- set numbered lines
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.relativenumber = true -- set relative number

-- Cursor
vim.cmd([[
set guicursor=a:Cursor/lCursor
set guicursor+=n-v:block
set guicursor+=i-c-ci:ver25
set guicursor+=r-cr:hor20,o:hor50
]])
-- set guicursor+=i-c-ci:ver25-blinkwait200-blinkon200-blinkoff100

-- Hide cursor when enter NvimTree
vim.cmd([[
augroup HideCursor
  autocmd!
  autocmd BufEnter NvimTree* if (bufname('%') =~ 'NvimTree*') | exec("hi Cursor blend=100 | setlocal cursorline")   | endif
  autocmd BufLeave NvimTree* if (bufname('%') =~ 'NvimTree*') | exec("hi Cursor blend=0   | setlocal nocursorline") | endif
  autocmd CmdlineEnter,CmdwinEnter * exec("set guicursor-=a:Cursor/lCursor")
  autocmd CmdlineLeave,CmdwinLeave * exec("set guicursor+=a:Cursor/lCursor")
augroup END
]])

