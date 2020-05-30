scriptencoding utf-8

function! s:cb(timer) abort
    if v:hlsearch
        " マッチする文字があれば、カーソルをつける
        if search(@/, 'cnw') !=# 0
            if !&cursorline
                set cursorline
                return
            endif
        endif
    else
        if &cursorline
            set nocursorline
        endif
    endif
endfunction

function! vimrc#auto_cursorline#exec() abort
    if exists('s:timer')
        call timer_stop(s:timer)
        unlet s:timer
    endif
    let s:timer = timer_start(100, function('s:cb'), {'repeat': -1})
endfunction
