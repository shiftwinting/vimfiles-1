scriptencoding utf-8

let g:prettier#exec_cmd_async = 1

augroup MyPrettier
    autocmd!
    autocmd BufEnter *.js,*.css,*.vue,*.html 
    \       nnoremap <buffer> <Space>bl :<C-u>PrettierAsync<CR>
augroup END
