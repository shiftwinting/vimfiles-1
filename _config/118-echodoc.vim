scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/echodoc.vim'))
    finish
endif

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'popup'
