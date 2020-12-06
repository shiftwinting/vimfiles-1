scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/highlightedundo.vim'))
    finish
endif

nmap u     <Plug>(highlightedundo-undo)
nmap <C-r> <Plug>(highlightedundo-redo)
nmap U     <Plug>(highlightedundo-Undo)
nmap g-    <Plug>(highlightedundo-gminus)
nmap g+    <Plug>(highlightedundo-gplus)

" Undo / Redo をハイライト
let g:highlightedundo#highlight_mode = 2

let g:highlightedundo#highlight_duration_add = 70
let g:highlightedundo#highlight_duration_delete = 70
