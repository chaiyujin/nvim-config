" ============================================================================ "
" Terminal settings
" ============================================================================ "

nnoremap <Leader>j :call ToggleTerminal("g:terminal")<CR>
inoremap <Leader>j <Esc>:call ToggleTerminal("g:terminal")<CR>
tnoremap <Leader>j <C-\><C-N>:call ToggleTerminal("g:terminal")<CR>

" Set default shell on windows
if has('win32')
  set shell=powershell.exe
endif

hi TermBg guibg=#242424
augroup AutoStartInsertTerminal
  autocmd!
  if has('nvim')
    autocmd TermOpen * startinsert
    autocmd TermOpen * :set winhighlight=Normal:TermBg
    autocmd BufEnter term://* startinsert!
    autocmd BufHidden term://* :set winhighlight=Normal:Normal
  else
    autocmd TerminalOpen * startinsert!
    autocmd TerminalWinOpen * startinsert!
    autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
  endif
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
  exe "below new | resize 12"
endfunction

function! ToggleTerminal(terminal_ref)
  
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
    " open term for nvim / vim in current window
    if has('nvim')
      call termopen(&shell, {a:terminal_ref})
    else
      call term_start(&shell, {'curwin': 1})
    endif

    set bufhidden=hide
    set nobuflisted
    set nonumber
    set norelativenumber
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
      echo "Failed to find terminal window! Create a new one."
      call CreateTerminalWindow()
      let {a:terminal_ref}.termwinid = win_getid()
      silent execute 'buffer' l:id
      silent execute 'bd #'
    endif
  endif 

endfunction
