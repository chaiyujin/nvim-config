" init.vim

if !exists('g:vscode')
  filetype plugin indent on
  syntax enable
  set termguicolors
  set nowrap
  set number
  set encoding=UTF-8
  set virtualedit=block
  " TextEdit might fail if hidden is not set.
  set hidden
  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup
  " Give more space for displaying messages.
  set cmdheight=2

  " Soft tab: insert spaces 
  set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  " Navigate windows
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
  inoremap <A-h> <C-\><C-N><C-w>h
  inoremap <A-j> <C-\><C-N><C-w>j
  inoremap <A-k> <C-\><C-N><C-w>k
  inoremap <A-l> <C-\><C-N><C-w>l
  nnoremap <A-h> <C-w>h
  nnoremap <A-j> <C-w>j
  nnoremap <A-k> <C-w>k
  nnoremap <A-l> <C-w>l

  " load other plugins and config files
  let $NVIM_CONFIG_DIR = expand('$HOME/.config/nvim')

  source $NVIM_CONFIG_DIR/plugs.vim
  source $NVIM_CONFIG_DIR/terminal.vim
  source $NVIM_CONFIG_DIR/smart_enter.vim

  if has('nvim-0.5')
    " nightly config
    luafile $NVIM_CONFIG_DIR/nightly.lua
  endif

  source $NVIM_CONFIG_DIR/stable.vim

  colorscheme onedark
endif

