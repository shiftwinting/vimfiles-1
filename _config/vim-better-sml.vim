scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/bettersml.vim'))
    finish
endif

" 'a を 'α ではなく、 'a を α で表示
let g:sml_greek_tyvar_show_tick = 0
