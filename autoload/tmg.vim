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

" get text from last selected words
function! tmg#getwords_last_visual() abort
    let l:reg = '"'
    " save
    let l:save_reg = getreg(l:reg)
    let l:save_regtype = getregtype(l:reg)
    let l:save_ve = &virtualedit

    set virtualedit=

    silent exec 'normal! gv"'.l:reg.'y'
    let l:result = getreg(l:reg, 1)

    " resotore
    call setreg(l:reg, l:save_reg, l:save_regtype)
    let &virtualedit = l:save_ve

    return l:result
endfunction
