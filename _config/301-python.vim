scriptencoding utf-8

if executable('black')
    function! ExecBlack() abort
        ! black %
    endfunction
    command! Black call ExecBlack()

    augroup MyBlack
        autocmd!
        autocmd Filetype python nnoremap <buffer> <silent> <Space>bl :<C-u>Black<CR>
    augroup END
endif
