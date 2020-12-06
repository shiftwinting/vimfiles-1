scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/poetv.vim'))
    finish
endif

let g:poetv_executables = ['poetry']
