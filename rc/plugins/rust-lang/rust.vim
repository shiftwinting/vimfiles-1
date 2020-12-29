UsePlugin 'rust.vim'
scriptencoding utf-8

" let g:cargo_shell_command_runner = 'call GotoCargoCmdResultWin() | terminal'

command! QCargoRun call QCrun()
function! QCrun() abort
  let l:curwin = win_getid()
  let l:result_bufnr = v:null
  for l:win in nvim_tabpage_list_wins(0)
    let l:bufnr = nvim_win_get_buf(l:win)

    " 100:cargo run みたいなバッファを探す
    if bufname(l:bufnr) =~# '\v\d+:cargo '
      " もし、あれば移動する
      let l:result_bufnr = l:bufnr
      break
    endif
  endfor

  if l:result_bufnr == v:null
    execute '15 new'
  else
    execute printf('noautocmd %d wincmd w', bufwinnr(l:bufnr))
  endif

  execute 'terminal cargo run'
  call win_gotoid(l:curwin)
endfunction
