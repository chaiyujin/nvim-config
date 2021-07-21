vim.g.indentLine_char = '▏'
-- let g:indentLine_char_list = ['|', '¦', '┆', '┊']

vim.cmd([[
  augroup DisableIndentLines
    autocmd!
    autocmd BufEnter * if (bufname('%') == '' || bufname('%') =~ 'term://.*') | IndentLinesDisable | endif
  augroup END
]])

