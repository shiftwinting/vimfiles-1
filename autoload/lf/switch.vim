scriptencoding utf-8

function! lf#switch#source_type() abort
    return 'command_funcref'
endfunction


" ---------------------
" source
" ---------------------
function! lf#switch#source(args) abort
    return 'git branch'
endfunction

" ---------------------
" accept
" ---------------------
function! lf#switch#accept(line, args) abort
    call system('git switch ' . a:line)
    echo printf(" Switched to branch '%s'", a:line)
endfunction

" ---------------------
" format_list
" ---------------------
function! lf#switch#format_list(list, args) abort
    return filter(copy(a:list), 'v:val[0] !=# "*"')
endfunction

" ---------------------
" format_line
" ---------------------
function! lf#switch#format_line(line, args) abort
    return trim(a:line)
endfunction
