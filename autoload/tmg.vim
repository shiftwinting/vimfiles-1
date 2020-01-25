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

" コマンドがないと怒られるため
function! tmg#delcommand(cmd) abort
    if exists(':'.a:cmd) ==# 2
        execute 'delcommand '.a:cmd
    endif
endfunction

" カレントウィンドウの右下に通知を表示する
function! tmg#popup_notification_botright(messages, ...) abort
    " option は上書き可能にする
    let l:arg_opt = a:0 == 0 ? {} : a:1

    let l:col = &columns - (&guioptions =~# 'r' ? 1 : 0)

    let l:opt = {
    \   'line': &lines - &cmdheight - 1,
    \   'col': l:col,
    \   'time': 3000,
    \   'pos': 'botright',
    \   'maxwidth': 30,
    \   'minwidth': 30,
    \   'minheight': 4,
    \   'padding': [0, 1, 0, 1],
    \   'border': [1, 1, 1, 1],
    \   'borderchars': ['-', '|', '-', '|', '+', '+', '+', '+'],
    \   'highlight': 'Todo',
    \   'wrap': 0,
    \   'tabpage': -1
    \}
    call popup_create(a:messages, extend(l:opt, l:arg_opt))
endfunction
