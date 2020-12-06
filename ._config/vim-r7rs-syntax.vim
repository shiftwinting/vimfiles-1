scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/r7rs.vim'))
    finish
endif

let g:r7rs_use_gauche = 1
