scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/cutlass.vim'))
    finish
endif

" move の m
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D
