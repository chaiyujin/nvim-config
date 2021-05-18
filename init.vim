" init.vim
if exists('g:vscode')
  " comment
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
else
  filetype plugin indent on
  syntax on
  set termguicolors
  set number
  set relativenumber
  set nowrap
  set encoding=UTF-8
  set hidden
  set nobackup
  set nowritebackup
  set virtualedit=block
  set cmdheight=2  " Give more space for displaying messages.
  set updatetime=300  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays
  set timeoutlen=300
  set shortmess+=c  " Don't pass messages to |ins-completion-menu|.
  set showmode
  set laststatus=2  " always show the status line
  set showtabline=2  " always show the tab line
  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Soft tab: insert spaces 
  set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType vim  setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType lua  setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType css  setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  " Map Esc
  inoremap <C-[> <Esc>

  " Navigate windows
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>
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

  " Better buffer navigation
  nnoremap <A--> :bprev<CR>
  nnoremap <A-=> :bnext<CR>
  nnoremap <A-q> :bp \| bd #<CR>

  " load other plugins and config files
  let $NVIM_CONFIG_DIR = expand('$HOME/.config/nvim')

  " source $NVIM_CONFIG_DIR/plugs.vim
  source $NVIM_CONFIG_DIR/buftabline.vim
  source $NVIM_CONFIG_DIR/terminal.vim
  source $NVIM_CONFIG_DIR/smart_enter.vim

  source $NVIM_CONFIG_DIR/onedark.vim
endif