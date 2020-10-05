scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/columnskip.vim'))
    finish
endif

nmap <A-n> <Plug>(columnskip:nonblank:next)
omap <A-n> <Plug>(columnskip:nonblank:next)
xmap <A-n> <Plug>(columnskip:nonblank:next)

nmap <A-p> <Plug>(columnskip:nonblank:prev)
omap <A-p> <Plug>(columnskip:nonblank:prev)
xmap <A-p> <Plug>(columnskip:nonblank:prev)
