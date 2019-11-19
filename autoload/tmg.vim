scriptencoding utf-8


function! tmg#get_fullpath(path) abort
    return substitute(expand(a:path), '\\', '/', 'g')
endfunction
