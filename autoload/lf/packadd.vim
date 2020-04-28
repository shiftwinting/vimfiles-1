scriptencoding utf-8

function! lf#packadd#source_type() abort
    return 'funcref'
endfunction

function! lf#packadd#source(args) abort
    let l:result = []
    for path in split(globpath(&packpath, '/pack/*/opt/*'))
        if isdirectory(path)
            call add(l:result, fnamemodify(path, ':t'))
        endif
    endfor
    return l:result
endfunction

function! lf#packadd#accept(line, args) abort
    execute 'packadd '.a:line
endfunction
