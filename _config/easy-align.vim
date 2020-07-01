scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/easy_align.vim'))
    finish
endif

xmap ga <Plug>(EasyAlign)
