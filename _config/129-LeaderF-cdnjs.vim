scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/Cdnjs.vim'))
    finish
endif

nnoremap <silent> <Space>fc :<C-u>Leaderf cdnjs --popup<CR>
