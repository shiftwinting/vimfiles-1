scriptencoding utf-8

" ! をつけるとすぐに実行
let s:menu = [
\   ['!git switch', 'Leaderf switch'],
\   ['!git dirty',  'Leaderf dirty'],
\   ['!git pull',   'GitPull'],
\   ['!git push',   'GitPush'],
\   ['!gina patch', 'GinaPatch'],
\   [' git new', 'Git switch -c '],
\]

function! lf#menu#source_type() abort
    return 'funcref'
endfunction

function! lf#menu#source(args) abort
    return lf#space_between(s:menu)
endfunction

function! lf#menu#accept(line, args) abort
    let l:cmd = trim(split(a:line, '|')[1])
    if a:line =~# '^!'
        exec l:cmd
    else
        call feedkeys(printf(':%s', l:cmd), 'n')
    endif
endfunction

function! lf#menu#highlights_def() abort
    return {
    \   'Lf_hl_menu_comment': '|\zs .*$',
    \}
endfunction

function! lf#menu#highlights_cmd() abort
    return [
    \   'hi link Lf_hl_menu_comment Comment',
    \]
endfunction
