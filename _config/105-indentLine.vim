scriptencoding utf-8

if empty(globpath(&rtp, 'after/plugin/indentLine.vim'))
    finish
endif

" インデントつけないバッファの名前
let g:indentLine_bufNameExclude = ['_.*']
let g:indentLine_bufTypeExclude = ['terminal']
let g:indentLine_fileTypeExclude = ['defx', 'calendar', 'help', 'json']
let g:indentLine_char = '|'

