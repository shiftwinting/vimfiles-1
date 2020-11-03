scriptencoding utf-8
UsePlugin 'vim-fugitive'

" タブで開く
nnoremap <silent> <Space>gs :<C-u>Gstatus<CR>\|:wincmd T<CR>

" Gstatus のウィンドウ内で実行できるマッピング
" > , < diff の表示
" =     diff のの切り替え
" a     add

" J/K  hung の移動

function! s:fugitive_my_settings() abort
    nnoremap <buffer>           <C-q> <C-w>q
    nnoremap <buffer>           q     <C-w>q
    nnoremap <buffer><silent>   ?     :<C-u>help fugitive-maps<CR>
    nnoremap <buffer>           s     s

    setlocal cursorline
endfunction


augroup MyFugitive
    autocmd!
    autocmd FileType fugitive call s:fugitive_my_settings()
    autocmd FileType gitcommit call s:gitcommit_settings()
augroup END

function! s:fugitive_init_buffer_if_empty() abort
    startinsert!
endfunction

function! s:gitcommit_settings() abort
    setlocal textwidth=72
    " 自動で折り返しを行う
    setlocal formatoptions+=t

    startinsert!
endfunction
