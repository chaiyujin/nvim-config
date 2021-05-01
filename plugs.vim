call plug#begin(stdpath('data') . '/plugged')

" Themes
" Plug 'markvincze/panda-vim'
" Plug 'tomasiser/vim-code-dark'
" Plug 'ayu-theme/ayu-vim' " or other package manager
" Plug 'joshdick/onedark.vim'
" Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" Indent
Plug 'Yggdroot/indentLine'
" Comment code
Plug 'tpope/vim-commentary'

" Plugs for deferent 
if has('nvim-0.5')
  " File tree
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
else
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'

  " Beautiful status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif

" Conquer of Completion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ==============================================================================
" indentLine
" ==============================================================================

let g:indentLine_char = '▏'  "  ¦, ┆, │, ⎸, or ▏
let g:indentLine_setColors = 1
let g:indentLine_color_gui = '#3E4452'
let g:indentLine_color_term = 237
let g:indentLine_showFirstIndentLevel = 0

" ==============================================================================
" status line, bufferline, file manager
" ==============================================================================

" Automaticly jump to last known cursor position
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

if has('nvim-0.5')
  " ----------------------------------------------------------------------------
  " bufferline
  " ----------------------------------------------------------------------------

  nnoremap <A-1> :lua require"bufferline".go_to_buffer(1)<CR>
  nnoremap <A-2> :lua require"bufferline".go_to_buffer(2)<CR>
  nnoremap <A-3> :lua require"bufferline".go_to_buffer(3)<CR>
  nnoremap <A-4> :lua require"bufferline".go_to_buffer(4)<CR>
  nnoremap <A-5> :lua require"bufferline".go_to_buffer(5)<CR>
  nnoremap <A-6> :lua require"bufferline".go_to_buffer(6)<CR>
  nnoremap <A-7> :lua require"bufferline".go_to_buffer(7)<CR>
  nnoremap <A-8> :lua require"bufferline".go_to_buffer(8)<CR>
  nnoremap <A-9> :lua require"bufferline".go_to_buffer(9)<CR>
  nnoremap <A-0> :lua require"bufferline".go_to_buffer(0)<CR>
  nnoremap <A--> :BufferLineCyclePrev<CR>
  nnoremap <A-=> :BufferLineCycleNext<CR>
  nnoremap <A-q> :bp \| bd #<CR>

  " alter buffer in terminal
  tnoremap <A-1> <C-\><C-n>:lua require"bufferline".go_to_buffer(1)<CR>
  tnoremap <A-2> <C-\><C-n>:lua require"bufferline".go_to_buffer(2)<CR>
  tnoremap <A-3> <C-\><C-n>:lua require"bufferline".go_to_buffer(3)<CR>
  tnoremap <A-4> <C-\><C-n>:lua require"bufferline".go_to_buffer(4)<CR>
  tnoremap <A-5> <C-\><C-n>:lua require"bufferline".go_to_buffer(5)<CR>
  tnoremap <A-6> <C-\><C-n>:lua require"bufferline".go_to_buffer(6)<CR>
  tnoremap <A-7> <C-\><C-n>:lua require"bufferline".go_to_buffer(7)<CR>
  tnoremap <A-8> <C-\><C-n>:lua require"bufferline".go_to_buffer(8)<CR>
  tnoremap <A-9> <C-\><C-n>:lua require"bufferline".go_to_buffer(9)<CR>
  tnoremap <A-0> <C-\><C-n>:lua require"bufferline".go_to_buffer(0)<CR>
  tnoremap <A--> <C-\><C-n>:BufferLineCyclePrev<CR>
  tnoremap <A-=> <C-\><C-n>:BufferLineCycleNext<CR>

  " ----------------------------------------------------------------------------
  " nvim-tree
  " ----------------------------------------------------------------------------

  let g:nvim_tree_side = 'left' "left by default
  let g:nvim_tree_width = 30 "30 by default
  let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
  let g:nvim_tree_gitignore = 1 "0 by default
  let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
  let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
  let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
  let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
  let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
  let g:nvim_tree_indent_markers = 0 "0 by default, this option shows indent markers when folders are open
  let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
  let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
  let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
  let g:nvim_tree_tab_open = 0 "0 by default, will open the tree when entering a new tab and the tree was previously open
  let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
  let g:nvim_tree_disable_netrw = 1 "1 by default, disables netrw
  let g:nvim_tree_hijack_netrw = 1 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  let g:nvim_tree_add_trailing = 0 "0 by default, append a trailing slash to folder names
  let g:nvim_tree_group_empty = 0 " 0 by default, compact folders that only contain a single folder into one node in the file tree
  let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
  let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ] " List of filenames that gets highlighted with NvimTreeSpecialFile
  let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }
  "If 0, do not show the icons for one of 'git' 'folder' and 'files'
  "1 by default, notice that if 'files' is 1, it will only display
  "if nvim-web-devicons is installed and on your runtimepath

  " default will show icon by default if no icon is provided
  " default shows no icon by default
  let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

  nnoremap <A-t> :NvimTreeToggle<CR>
  nnoremap <leader>r :NvimTreeRefresh<CR>
  nnoremap <leader>n :NvimTreeFindFile<CR>
  " NvimTreeOpen and NvimTreeClose are also available if you need them

  " a list of groups can be found at `:help nvim_tree_highlight`
  " highlight NvimTreeFolderIcon guibg=blue
  " ------------------------------------------
else

  " ---------------------------------------------------------------------------
  " airline
  " ---------------------------------------------------------------------------

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 0
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#branch#enabled = 1
  let g:airline_powerline_fonts = 1

  nmap <A-1> <Plug>AirlineSelectTab1
  nmap <A-2> <Plug>AirlineSelectTab2
  nmap <A-3> <Plug>AirlineSelectTab3
  nmap <A-4> <Plug>AirlineSelectTab4
  nmap <A-5> <Plug>AirlineSelectTab5
  nmap <A-6> <Plug>AirlineSelectTab6
  nmap <A-7> <Plug>AirlineSelectTab7
  nmap <A-8> <Plug>AirlineSelectTab8
  nmap <A-9> <Plug>AirlineSelectTab9
  nmap <A-0> <Plug>AirlineSelectTab0
  nmap <A--> <Plug>AirlineSelectPrevTab
  nmap <A-=> <Plug>AirlineSelectNextTab

  tmap <A-1> <C-\><C-n><Plug>AirlineSelectTab1
  tmap <A-2> <C-\><C-n><Plug>AirlineSelectTab2
  tmap <A-3> <C-\><C-n><Plug>AirlineSelectTab3
  tmap <A-4> <C-\><C-n><Plug>AirlineSelectTab4
  tmap <A-5> <C-\><C-n><Plug>AirlineSelectTab5
  tmap <A-6> <C-\><C-n><Plug>AirlineSelectTab6
  tmap <A-7> <C-\><C-n><Plug>AirlineSelectTab7
  tmap <A-8> <C-\><C-n><Plug>AirlineSelectTab8
  tmap <A-9> <C-\><C-n><Plug>AirlineSelectTab9
  tmap <A-0> <C-\><C-n><Plug>AirlineSelectTab0
  nmap <A--> <C-\><C-n><Plug>AirlineSelectPrevTab
  nmap <A-=> <C-\><C-n><Plug>AirlineSelectNextTab

  nnoremap <A-q> :bp \| bd #<CR>

  " ---------------------------------------------------------------------------
  " NERDTree
  " ---------------------------------------------------------------------------

  nnoremap <A-t> :NERDTreeToggle<CR>
  augroup MyNERDTree
    autocmd!
    " Start NERDTree and put the cursor back in the other window
    " autocmd VimEnter * NERDTree | wincmd p
    " Start NERDTree when Vim starts with a directory argument.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

    " Auto refresh when enter NERDTree
    autocmd BufEnter NERD_tree_* | execute 'normal R'

    " Exit Vim if NERDTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif
  augroup END

endif
