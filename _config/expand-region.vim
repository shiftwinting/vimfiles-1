scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/expand_region.vim'))
    finish
endif

nmap <M-j> <Plug>(expand_region_shrink)
vmap <M-j> <Plug>(expand_region_shrink)
nmap <M-k> <Plug>(expand_region_expand)
vmap <M-k> <Plug>(expand_region_expand)
