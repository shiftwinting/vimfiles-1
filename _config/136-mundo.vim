scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/mundo.vim'))
    finish
endif

" プレビューを下に表示
let g:mundo_preview_bottom = 1

nnoremap <silent> <Space>;u :<C-u>MundoShow<CR>
