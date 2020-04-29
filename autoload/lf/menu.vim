scriptencoding utf-8

let s:menu = [
\   ['git switch', 'Leaderf switch'],
\   ['git dirty',  'Leaderf dirty'],
\   ['git pull',   'GitPull'],
\   ['git push',   'GitPush'],
\   ['gina patch', 'GinaPatch'],
\]

function! lf#menu#source_type() abort
    return 'funcref'
endfunction

function! lf#menu#source(args) abort
    return lf#space_between(s:menu)
endfunction

function! lf#menu#accept(line, args) abort
    exec trim(split(a:line, '|')[1])
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
