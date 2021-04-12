scriptencoding utf-8
UsePlugin 'vim-easy-align'

if empty(globpath(&rtp, 'autoload/easy_align.vim'))
    finish
endif

xmap ga <Plug>(LiveEasyAlign)

