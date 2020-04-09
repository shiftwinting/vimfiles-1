scriptencoding utf-8

if exists('b:did_ftplugin_tmg')
    finish
endif

let b:did_ftplugin_tmg = 1

" from jedi-vim
function! s:smart_auto_mappings() abort
    let l:line = line('.')
    if search('\m^\s*from\s\+[A-Za-z0-9._]\{1,50}\%#\s*$', 'bcn', l:line)
        " from xxx<Space>
        " が
        " from xxx import<C-x><C-o>
        return "\<Space>import\<Space>\<C-x>\<C-o>"
    elseif search('\v^\s*from$', 'bcn', l:line)
        " from<Space>
        " が
        " from <C-x><C-o>
        return "\<Space>\<C-x>\<C-o>"
    elseif search('\v^\s*import$', 'bcn', l:line)
        " import<Space>
        " が
        " import <C-x><C-o>
        return "\<Space>\<C-x>\<C-o>"
    endif
    return "\<Space>"
endfunction


" ---------------
" mappings
" ---------------
inoremap <silent> <buffer> <expr> <Space> <SID>smart_auto_mappings()



" ---------------
" options
" ---------------
setlocal sw=4 sts=4 ts=4 et
