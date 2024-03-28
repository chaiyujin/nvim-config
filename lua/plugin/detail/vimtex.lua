local utils = require("core.utils")
local M = {"lervag/vimtex", lazy=false}

-- Lazy-load on filetype
-- M.ft = { "tex" }

-- `init` functions are always executed during startup
M.init = function()
   vim.g.vimtex_view_method = 'skim'
   vim.g.vimtex_view_automatic = 1
   -- vim.cmd('source ' .. vim.fn.stdpath("config") .. '/vim/vimtex.vim')
   -- vim.g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
   -- vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
   -- vim.g.vimtex_compiler_engine = 'latexmk'
   -- vim.g.maplocalleader = '\\'

   vim.cmd[[
   function! s:write_server_name() abort
     let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
     call writefile([v:servername], nvim_server_file)
   endfunction
   augroup vimtex_common
     autocmd!
     autocmd FileType tex call s:write_server_name()
   augroup END
   ]]
end

-- packer config callback, after loading plugin
M.config = function(_, opts)
   vim.cmd("call vimtex#init()")
end

return M
