scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/columnskip.vim'))
    finish
endif

nmap zj <Plug>(columnskip:nonblank:next)
omap zj <Plug>(columnskip:nonblank:next)
xmap zj <Plug>(columnskip:nonblank:next)

nmap zk <Plug>(columnskip:nonblank:prev)
omap zk <Plug>(columnskip:nonblank:prev)
xmap zk <Plug>(columnskip:nonblank:prev)
