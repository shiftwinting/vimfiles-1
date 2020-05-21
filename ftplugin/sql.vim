nnoremap <Space>bl :<C-u>SQLFmt<CR>

if !empty(globpath(&rtp, 'autoload/nrrwrgn.vim'))
    vnoremap <Space>bl :NR<CR> \| :SQLFmt<CR> \| :write<CR> \| :close<CR>
endif

setlocal sw=2 sts=2 ts=2 et
