function! IsEditorBuffer(bufname)
  if a:bufname =~ "NERD_tree_\\d\\+" | return v:false | endif
  if a:bufname =~ "term:.*" | return v:false | endif
  if a:bufname =~ "NvimTree*" | return v:false | endif
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
  elseif !IsEditorBuffer(l:bufname)
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

autocmd BufEnter * if IsEditorBuffer(bufname('%')) | call SmartBufEnter(bufnr()) | endif
