scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/lambdalisue_fin.vim'))
    finish
endif


function! s:my_ft_fin() abort
    cmap <buffer><nowait> <C-k> <Plug>(fin-line-prev)
    cmap <buffer><nowait> <C-j> <Plug>(fin-line-next)
    cmap <buffer><nowait> <C-^> <Plug>(fin-matcher-next)
    cmap <buffer><nowait> <C-6> <Plug>(fin-matcher-next)
endfunction

augroup my-ft-fin
    autocmd!
    autocmd FileType fin call s:my_ft_fin()
augroup END
