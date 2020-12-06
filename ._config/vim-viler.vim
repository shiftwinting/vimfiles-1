scriptencoding utf-8

finish

if empty(globpath(&rtp, 'autoload/viler.vim'))
    finish
endif

nnoremap <C-e> :<C-u>call viler#open('.')<CR>

function! s:my_ft_viler() abort
    nmap <buffer> <C-l> <Plug>(viler-open-file)
    nmap <buffer> <C-h> <Plug>(viler-cd-up)
endfunction

augroup my-ft-viler
    autocmd!
    autocmd FileType viler call s:my_ft_viler()
augroup END
