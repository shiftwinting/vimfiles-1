scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/winresizer.vim'))
    finish
endif

let g:winresizer_start_key='ss'
