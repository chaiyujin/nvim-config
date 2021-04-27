call plug#begin(stdpath('data') . '/plugged')

" Comment code
Plug 'tpope/vim-commentary'

if !exists('g:vscode')
  " Themes
  Plug 'markvincze/panda-vim'
  Plug 'tomasiser/vim-code-dark'
  Plug 'ayu-theme/ayu-vim' " or other package manager
  Plug 'joshdick/onedark.vim'
  " Indent
  Plug 'Yggdroot/indentLine'
  " File tree and icons
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  " Beautiful status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Git helper
  Plug 'tpope/vim-fugitive'
  " Conquer of Completion 
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()

" ============================================================================ "
" Common settings
" ============================================================================ "

set nowrap
set encoding=UTF-8
set virtualedit=block

" Soft tab: insert spaces 
set      tabstop=4 shiftwidth=4 softtabstop=4 expandtab
setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab  " 2 spaces for init.vim

" Navigate windows
if !exists('g:vscode')
  set number
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

" ============================================================================ "
" Color Themes & Appearance
" ============================================================================ "

if !exists('g:vscode')
  syntax enable
  set termguicolors   " enable true colors support

  " color panda
  " colorscheme codedark
  " let ayucolor = "dark"    " light, mirage, dark
  " colorscheme ayu
  colorscheme onedark

  " let g:airline_theme ='luna'
  " let g:airline_theme = 'codedark'
  " let g:airline_theme = 'ayu'
  let g:airline_theme = 'onedark'

  " IndentLine {{
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_setColors = 0
  " }}
endif

" ============================================================================ "
" File manager
" ============================================================================ "

if !exists('g:vscode')
  nnoremap <A-t> :NERDTreeToggle<CR>
  " Auto refresh when enter NERDTree
  autocmd BufEnter NERD_tree_* | execute 'normal R'

  " Buffer change
  " Airline {{
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 0
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#branch#enabled = 1
  let g:airline_powerline_fonts = 1
  " }}

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
  nnoremap <A-q> :bp \| bd #<CR>

  function! IsEditorBuffer(bufname)
    if a:bufname =~ "NERD_tree_\\d\\+" | return v:false | endif
    if a:bufname =~ "term:.*" | return v:false | endif
    return v:true
  endfunction

  function! SmartBufEnter(bufnr)
    let l:buftype = getbufvar(a:bufnr, '&buftype', '__ERROR__')
    let l:bufname = bufname(a:bufnr)
    if l:buftype =~ "__ERROR__"
      echo "Failed to get buftype for bufnr" a:bufnr
      return
    elseif len(l:bufname) == 0
      " echo "Empty Buffer, Ingore"
      return
    endif

    " Buffers, we should ignore
    if l:buftype =~ "terminal" || l:buftype =~ "help"
      return
    elseif l:bufname =~ "NERD_tree_\\d\\+"
      return
    endif

    " echo "Try to enter buffer" l:bufname "nr:" a:bufnr "(" l:buftype ")"
    " check current window is good
    let l:prev_bufname = bufname('#')
    if IsEditorBuffer(l:prev_bufname)
      " echo "Current buffer is good" l:prev_bufname
      execute "buffer".a:bufnr
      return
    endif

    " current window is not good,
    " we have to find a good one
    let l:windows = map(
      \ copy(getwininfo()),
      \ "{'bufname':bufname(winbufnr(v:val.winnr)), 'win': v:val}"
    \)
    " filter good windows: not NERDTree, not terminal
    let l:good_wins = filter(l:windows,
      \ "IsEditorBuffer"."(v:val.bufname)" 
    \)

    if len(l:good_wins) > 0
      " use the first window
      echo "Found" len(l:good_wins) "editor windows, use the first:" l:good_wins[0].win.winid
      execute "buffer#"
      call win_gotoid(l:good_wins[0].win.winid)
      execute "buffer".a:bufnr
    endif
    " TODD: No good window
  endfunction

  augroup FileManger
    autocmd!
    " Start NERDTree and put the cursor back in the other window
    " autocmd VimEnter * NERDTree | wincmd p
    " Start NERDTree when Vim starts with a directory argument.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

    " Exit Vim if NERDTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif

    " If another buffer tries to replace NERDTree or terminal, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('%') !~ 'term://.*' && bufname('%') !~'NERD_tree_\d\+' | call SmartBufEnter(bufnr()) | endif
    " autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    "  \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

    " Automaticly jump to last known cursor position
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup END
endif

" ============================================================================ "
" Terminal settings
" ============================================================================ "

if !exists('g:vscode')
  tnoremap <Esc> <C-\><C-n>
  nnoremap <C-j> :call ToggleTerminal("g:terminal")<CR>
  inoremap <C-j> <Esc>:call ToggleTerminal("g:terminal")<CR>
  tnoremap <C-j> <C-\><C-N>:call ToggleTerminal("g:terminal")<CR>

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

  " Set default shell on windows
  if has('win32')
    set shell=powershell.exe
  endif

  augroup AutoStartInsertTerminal
    autocmd!
    autocmd TermOpen * startinsert
    autocmd BufEnter term://* startinsert!
  augroup END

  " Terminal toggle
  let s:default_terminal = {
    \ 'loaded': v:null,
    \ 'termbufferid': v:null,
    \ 'termwinid': v:null,
    \ 'prev_winid': v:null
  \}

  ""
  " Preserve the alternate_buffer of the current window when opening and closing
  " the terminal. Default is 1 (true)
  let g:preserve_alternate_buffer = get(g:, 'preserve_alternate_buffer', 1)

  function! CreateTerminalWindow()
    exe "below new | resize 10"
  endfunction

  function! ToggleTerminal(terminal_ref)
    if !has('nvim')
      return v:false
    endif
    
    if !exists(a:terminal_ref)
      let {a:terminal_ref} = copy(s:default_terminal)
    endif

    let s:tr = a:terminal_ref
    function! {a:terminal_ref}.on_exit(jobid, data, event)
      let {s:tr} = copy(s:default_terminal)
    endfunction 
    
    " If Terminal not open
    if !get({a:terminal_ref}, "loaded")
      let {a:terminal_ref}.prev_winid = win_getid()

      call CreateTerminalWindow()
      call termopen(&shell, {a:terminal_ref})
      "set bufhidden=hide
      "set nobuflisted
      let {a:terminal_ref}.loaded = v:true
      let {a:terminal_ref}.termbufferid = bufnr('')
      let {a:terminal_ref}.termwinid = win_getid()
      echo "New Terminal: bufferid" {a:terminal_ref}.termbufferid "winid" {a:terminal_ref}.termwinid
      return v:true
    endif

    if get({a:terminal_ref}, "termwinid") ==# win_getid()
      echo "Go back to origin buffer if curretn buffer is terminal"
      execute "hide"
      let l:wid = get({a:terminal_ref}, "prev_winid")
      call win_gotoid(l:wid)
    else
      echo "Go to terminal due to current buffer is not terminal"
      " Go to terminal buffer if is loaded but not current buffer
      let l:id = get({a:terminal_ref}, "termbufferid")
      let l:wid = get({a:terminal_ref}, "termwinid")
      let {a:terminal_ref}.prev_winid = win_getid()
      let l:res = win_gotoid(l:wid)
      if l:res == 1
        silent execute 'keepjumps buffer' l:id
      else
        " echo "Failed to find terminal window! Create a new one."
        call CreateTerminalWindow()
        let {a:terminal_ref}.termwinid = win_getid()
        silent execute 'buffer' l:id
        silent execute 'bd #'
        execute "startinsert"
      endif
    endif 

  endfunction
endif

" ============================================================================ "
" coc.nvim relative settings
" ============================================================================ "

if !exists('g:vscode')

  " Set internal encoding of vim, not needed on neovim, since coc.nvim using some
  " unicode characters in the file autoload/float.vim

  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
endif

