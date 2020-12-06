scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/translator.vim'))
    finish
endif

let g:translator_window_borderchars = ['-', '|', '-', '|', '+', '+', '+', '+']

