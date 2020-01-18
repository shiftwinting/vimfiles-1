scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/Bookmark.vim'))
    finish
endif

nnoremap <silent> <Space>fb :<C-u>Leaderf bookmark<CR>
let g:Lf_BookmarkAcceptSelectionCmd = 'Vaffle'

command! -nargs=? BookmarkAdd call leaderf#Bookmark#add(getcwd(), <f-args>)
