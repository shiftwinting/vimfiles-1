scriptencoding utf-8

" タブで開く
nnoremap <silent> gs :<C-u>Gstatus<CR>\|:wincmd T<CR>

" Gstatus のウィンドウ内で実行できるマッピング
" > , < diff の表示

function! s:fugitive_my_settings() abort
    nnoremap <buffer>           <C-q> <C-w>q
    nnoremap <buffer>           q     <C-w>q
    nnoremap <buffer><silent>   ?     :<C-u>help fugitive-maps<CR>
    nnoremap <buffer>           s     <Nop>

    nnoremap <buffer>           <A-j> ]c
    nnoremap <buffer>           <A-k> [c
endfunction

function! s:fugitive_init_buffer_if_empty() abort
    let l:lines = line('$')
    exec 'resize ' . l:lines
    setlocal winfixheight
    startinsert!

    " mappings
    nnoremap <buffer> <C-q> :<C-u>quit!<CR>
endfunction

augroup MyFugitive
    autocmd!
    autocmd FileType fugitive call s:fugitive_my_settings()
    autocmd FileType gitcommit call s:fugitive_init_buffer_if_empty()
augroup END
