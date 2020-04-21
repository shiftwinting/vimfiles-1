scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/vim-autoimport.vim'))
    finish
endif

augroup MyAutoImport
    autocmd!
    autocmd User ALELintPost if &ft ==# 'python' | call s:python_autoimport() | endif
augroup END

function! s:python_autoimport() abort
    nosilent echomsg hello
endfunction
