scriptencoding utf-8

" タブで開く
nnoremap <silent> <Space>gs :<C-u>Gstatus<CR>\|:wincmd T<CR>

" Gstatus のウィンドウ内で実行できるマッピング
" > , < diff の表示
" =     diff のの切り替え
" a     add

" J/K  hubk の移動

function! s:fugitive_my_settings() abort
    nnoremap <buffer>           <C-q> <C-w>q
    nnoremap <buffer>           q     <C-w>q
    nnoremap <buffer><silent>   ?     :<C-u>help fugitive-maps<CR>
    nnoremap <buffer>           s     <Nop>

    nnoremap <buffer>           P     :<C-u>call <SID>add_p()<CR>

    setlocal cursorline
endfunction


function! s:fugitive_init_buffer_if_empty() abort
    let l:lines = line('$')
    exec 'resize ' . l:lines
    setlocal winfixheight
    startinsert!

    " mappings
    nnoremap <buffer> <C-q> :<C-u>quit!<CR>
endfunction


function! s:add_p() abort
    " カレント行のファイルを開く
    let l:root = FugitiveWorkTree()
    let l:file = matchstr(getline('.'), '^[A-Z?] \zs.*')
    execute 'vsplit ' . l:root . '/' . l:file

    GitGutterFold
    GitGutterLineHighlightsEnable

    nnoremap <buffer><silent> q :<C-u>GitGutterLineHighlightsDisable <bar> quit<CR>
endfunction


augroup MyFugitive
    autocmd!
    autocmd FileType fugitive call s:fugitive_my_settings()
    " autocmd FileType gitcommit call s:fugitive_init_buffer_if_empty()
augroup END
