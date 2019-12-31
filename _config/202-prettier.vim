scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/prettier.vim'))
    finish
endif

let g:prettier#exec_cmd_async = 1

augroup MyPrettier
    autocmd!
    autocmd BufEnter *.js,*.css,*.vue,*.html 
    \       nnoremap <buffer> <Space>bl :<C-u>PrettierAsync<CR>
augroup END
