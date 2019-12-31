scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/black'))
    finish
endif

" :Blackでの1行を設定
let g:black_linelength = 99

augroup MyBlack
    autocmd!
    autocmd Filetype python nnoremap <buffer> <silent> <Space>bl :<C-u>Black<CR>
augroup END
