scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/highlightedyank.vim'))
    finish
endif

let g:highlightedyank_highlight_duration = 70
