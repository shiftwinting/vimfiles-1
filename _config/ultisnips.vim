scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/ultisnips.vim'))
    finish
endif

" 展開
let g:UltiSnipsExpandTrigger = '<C-j>'
" 次
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
" 前
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
