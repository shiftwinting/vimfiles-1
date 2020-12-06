scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/vim-signify.vim'))
    finish
endif

let g:signify_priority = 999
