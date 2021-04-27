" init.vim

if !exists('g:vscode')
  filetype plugin indent on
  set termguicolors
  set nowrap
  set encoding=UTF-8
  set virtualedit=block
  syntax enable

  " Soft tab: insert spaces 
  set      tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab  " 2 spaces for init.vim
  set number

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
endif

let $NVIM_CONFIG_DIR = expand('$HOME/.config/nvim')

source $NVIM_CONFIG_DIR/plugs.vim
colorscheme onedark

if has('nvim-0.5')
  " nightly config
  luafile $NVIM_CONFIG_DIR/nightly.lua

else
  " stable config
  source $NVIM_CONFIG_DIR/stable.vim
endif
