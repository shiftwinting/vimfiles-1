scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/autopairs.vim'))
    finish
endif


" スペースのペアを無くす
let g:AutoPairsMapSpace = 0
