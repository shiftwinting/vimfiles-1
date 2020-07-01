scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/columnskip.vim'))
    finish
endif

nmap zj <Plug>(columnskip-j)
omap zj <Plug>(columnskip-j)
xmap zj <Plug>(columnskip-j)

nmap zk <Plug>(columnskip-k)
omap zk <Plug>(columnskip-k)
xmap zk <Plug>(columnskip-k)
