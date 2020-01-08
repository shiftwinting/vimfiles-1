scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/Bookmark.vim'))
    finish
endif

nnoremap <silent> <Space>fb :<C-u>Leaderf bookmark --popup<CR>
let g:Lf_BookmarkAcceptSelectionCmd = 'Vaffle'
