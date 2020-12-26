UsePlugin 'rust.vim'
scriptencoding utf-8

let g:cargo_shell_command_runner = 'call GotoCargoCmdResultWin() | terminal'
function! GotoCargoCmdResultWin() abort
  for l:win in nvim_tabpage_list_wins(0)
    let l:bufnr = nvim_win_get_buf(l:win)

    " 100:cargo run みたいなバッファを探す
    if bufname(l:bufnr) =~# '\v\d+:cargo '
      " もし、あれば移動する
      execute printf('noautocmd %d wincmd w', bufwinnr(l:bufnr))
      return
    endif
  endfor

  execute 'new'
endfunction
