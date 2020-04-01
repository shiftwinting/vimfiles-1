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
        return "\<Space>import\<Space>"
    endif
    return "\<Space>"
endfunction


function! s:settings() abort
    inoremap <silent> <buffer> <space> <C-R>=<SID>smart_auto_mappings()<CR>
endfunction

augroup MyPython
    autocmd!
    autocmd FileType python call <SID>settings()
augroup END
