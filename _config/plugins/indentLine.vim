scriptencoding utf-8

UsePlugin 'indentLine'

" インデントつけないバッファの名前
let g:indentLine_bufNameExclude = ['_.*']
let g:indentLine_bufTypeExclude = ['terminal']
let g:indentLine_fileTypeExclude = [
\   'defx',
\   'calendar', 
\   'help', 
\   'json',
\   'sql',
\   'r7rs',
\   'scheme',
\   'smlnj',
\   'ocaml',
\   'sml',
\]
let g:indentLine_char = '|'
