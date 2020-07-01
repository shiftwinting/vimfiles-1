scriptencoding utf-8

" nmap <silent> <expr> <C-p> yoink#isSwapping()
" \       ? '<plug>(YoinkPostPasteSwapBack)'
" \       : ':<C-u>Leaderf command --popup --run-immediately<CR>'
" nmap <C-n> <plug>(YoinkPostPasteSwapForward)
nmap p     <plug>(YoinkPaste_p)
nmap P     <plug>(YoinkPaste_P)

" d x y で履歴に追加する
" XXX: これ動作してる...？
let g:yoinkIncludeDeleteOperations = 1

" ペーストした後、カーソルを移動させる
let g:yoinkMoveCursorToEndOfPaste = 1
