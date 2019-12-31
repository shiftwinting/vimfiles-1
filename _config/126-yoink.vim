scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/yoink.vim'))
    finish
endif

nmap <C-p> <plug>(YoinkPostPasteSwapBack)
nmap <C-n> <plug>(YoinkPostPasteSwapForward)
nmap p     <plug>(YoinkPaste_p)
nmap P     <plug>(YoinkPaste_P)

" d x y で履歴に追加する
" XXX: これ動作してる...？
let g:yoinkIncludeDeleteOperations = 1

" ペーストした後、カーソルを移動させる
let g:yoinkMoveCursorToEndOfPaste = 1
