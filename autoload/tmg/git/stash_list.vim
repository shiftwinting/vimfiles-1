scriptencoding utf-8

let s:V = vital#vital#new()
let s:Process = s:V.import('System.Process')

" ====================
" stash list を表示する
" ====================
function! s:stash_list() abort
    let l:res = s:Process.execute('git stash list --pretty="%s"')
    if l:res.success
        
    endif
endfunction
