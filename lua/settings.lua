vim.cmd([[
filetype plugin indent on
syntax enable
set termguicolors
set nowrap
set number
set relativenumber
set encoding=UTF-8
set virtualedit=block
set hidden
set nobackup
set nowritebackup
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
]])

-- vim.o.termguicolors = true -- set term gui colors most terminals support this
-- vim.o.t_Co = "256"

-- autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
-- autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
