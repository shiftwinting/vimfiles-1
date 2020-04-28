scriptencoding utf-8

function! lf#ghq#source_type() abort
    return 'commnad_funcref'
endfunction

function! lf#ghq#source(args) abort
    return 'ghq list'
endfunction

function! lf#ghq#accept(line, args) abort
    let l:path = $GHQ_ROOT . '/github.com/' . a:line
    execute 'tabe | tcd ' . l:path
endfunction

function! lf#ghq#format_line(line, args) abort
    " 'github.com ' 以降を取得
    return a:line[11:]
endfunction
