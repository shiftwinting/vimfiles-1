scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/fugitive.vim'))
    finish
endif

nnoremap <silent> gs :<C-u>Gstatus<CR>

" Gstatus のウィンドウ内で実行できるマッピング
" > , < diff の表示

function! s:fugitive_my_settings() abort
    nnoremap <buffer>           <C-q> <C-w>q
    nnoremap <buffer>           q     <C-w>q
    nnoremap <buffer><silent>   ?     :<C-u>help fugitive-maps<CR>
    nnoremap <buffer>           s     <Nop>
endfunction

function! s:fugitive_init_buffer_if_empty() abort
    resize 3
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
