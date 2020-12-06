scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/paredit.vim'))
    finish
endif

let g:paredit_shortmaps = 1

augroup MyParedit
    autocmd!
    autocmd Filetype scheme call PareditInitBuffer()
    autocmd Filetype r7rs call PareditInitBuffer()
    autocmd BufEnter if &filetype ==# 'r7rs' | call PareditInitBuffer() | endif
augroup END
