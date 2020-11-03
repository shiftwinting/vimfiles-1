scriptencoding utf-8

UsePlugin 'NrrwRgn'

if empty(globpath(&rtp, 'autoload/nrrwrgn.vim'))
    finish
endif

" デフォルトのマッピングをしない
let g:nrrw_rgn_nomap_nr = 1

vnoremap <Space>nr :NR<CR>

