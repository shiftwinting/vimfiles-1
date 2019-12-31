scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/asterisk.vim'))
    finish
endif

map * <Plug>(asterisk-gz*)
map # <Plug>(asterisk-z#)
map g* <Plug>(asterisk-z*)
map g# <Plug>(asterisk-z#)

let g:asterisk#keeppos = 1
