scriptencoding utf-8


" バックスラッシュをスラッシュにして返す
function! tmg#get_fullpath(path) abort
    return substitute(expand(a:path), '\\', '/', 'g')
endfunction

" 表示されているか返す
function! s:find_visible_file(path) abort
    for l:buf in getbufinfo({'buflisted': 1})
        if tmg#get_fullpath(l:buf.name) ==# a:path &&
        \   !empty(l:buf.windows)
            return 1
        endif
    endfor
    return 0
endfunction


function! tmg#DropOrTabedit(path) abort
    let l:path = tmg#get_fullpath(a:path)
    if s:find_visible_file(l:path)
        execute 'drop ' . l:path
    else
        execute 'tabedit ' . l:path
    endif
endfunction

