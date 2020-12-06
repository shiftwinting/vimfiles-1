scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/mr.vim'))
    finish
endif

" nnoremap <silent> <Space>fk :<C-u>Mru \| copen<CR>
