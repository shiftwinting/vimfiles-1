scriptencoding utf-8

if exists('b:did_ftplugin_tmg')
    finish
endif

let b:did_ftplugin_tmg = 1


function! s:space() abort
    let l:col = getpos('.')[2]
    " 先頭でリストではなかったら、* とする
    if l:col ==# 1 && getline('.') !~# '^\s*\* .*'
        return '* '
    endif

    " インデント
    let l:line = getline('.')[:l:col]
    if l:line =~# '\v^\s*\* \s*$'
        return "\<C-t>"
    endif
    return "\<Space>"
endfunction


" ====================
" mappings
" ====================
inoremap <buffer>        <Tab>   <C-t>
inoremap <buffer>        <S-Tab> <C-d>
inoremap <buffer> <expr> <Space> <SID>space()
" inoremap <buffer> <expr> <CR>    <SID>cr()

function! s:cr() abort
    if getline('.') =~# '\v^\s*\*'
        return "\<C-o>:InsertNewBullet\<CR>"
    endif
    return "\<CR>"
endfunction

if exists('g:loaded_bullets_vim')
    inoremap <silent> <buffer> <expr> <CR> <SID>cr()
    nnoremap <silent> <buffer> o    :<C-u>InsertNewBullet<CR>
    " vnoremap <silent> <buffer> gN   <C-u>:RenumberSelection<CR>
    " nnoremap <silent> <buffer> gN   <C-u>:RenumberList<CR>
    " nnoremap <silent> <buffer> <Space>x <C-u>:ToggleCheckbox<CR>
endif


" ====================
" options
" ====================
setlocal sw=2 sts=2 ts=2 et



" ====================
" autocmds
" ====================

" augroup My_ft_markdown
"     autocmd!
"     " 本当は保存するべきだけどいいや
"     autocmd InsertEnter setlocal conceallevel=0
"     autocmd InsertLeave setlocal conceallevel=2
" augroup END
