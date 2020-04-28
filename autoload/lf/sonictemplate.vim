scriptencoding utf-8


" TODO: Preview する (どのファイル化を検索するロジック難しそう？)

function! lf#sonictemplate#source_type() abort
    return 'funcref'
endfunction

function! lf#sonictemplate#source(args) abort
    return sonictemplate#complete('', '', '')
endfunction

function! lf#sonictemplate#accept(line, args) abort
    execute 'Template '.a:line
endfunction
