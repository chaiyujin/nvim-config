" init.vim
set termguicolors

let $NVIM_CONFIG_DIR = expand('$HOME/.config/nvim')

if has('nvim-0.5')
  " nightly config
  " source $NVIM_CONFIG_DIR/nightly.vim
  call plug#begin(stdpath('data') . '/plugged')

    " Comment code
  Plug 'tpope/vim-commentary'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }

  call plug#end()

  colorscheme material

  luafile $NVIM_CONFIG_DIR/nightly.lua
else
  " stable config
  source $NVIM_CONFIG_DIR/stable.vim
endif
