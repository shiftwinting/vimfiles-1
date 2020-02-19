scriptencoding utf-8

nnoremap <silent> <Space>fb :<C-u>Leaderf bookmark<CR>
let g:Lf_BookmarkAcceptSelectionCmd = 'Leaderf filer'

command! -nargs=? BookmarkAddHere call leaderf#Bookmark#add(getcwd(), <f-args>)
