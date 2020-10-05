scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/asyncrun.vim'))
    finish
endif

let g:asyncrun_open = 15
