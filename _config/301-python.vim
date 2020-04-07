scriptencoding utf-8

" if executable('black')
"     function! ExecBlack() abort
"         ! black %
"     endfunction
"     command! Black call ExecBlack()
"
"     augroup MyBlack
"         autocmd!
"         autocmd Filetype python nnoremap <buffer> <silent> <Space>bl :<C-u>Black<CR>
"     augroup END
" endif


" from jedi-vim
function! s:smart_auto_mappings() abort
    if search('\m^\s*from\s\+[A-Za-z0-9._]\{1,50}\%#\s*$', 'bcn', line('.'))
        " from xxx<Space>
        "   -> 
        " from xxx import<C-x><C-o>
        return "\<Space>import\<Space>\<C-x>\<C-o>"
    elseif search('\v^\s*from', 'bcn', line('.'))
        " from<Space>
        " from <C-x><C-o>
        return "\<Space>\<C-x>\<C-o>"
    endif
    return "\<Space>"
endfunction


function! s:settings() abort
    inoremap <silent> <buffer> <expr> <Space> <SID>smart_auto_mappings()
endfunction


augroup MyPython
    autocmd!
    autocmd FileType python call <SID>settings()
augroup END
