scriptencoding utf-8

xmap     [tr <Plug>(VTranslate)
xmap     ]tr <Plug>(VTranslateBang)
" カーソル下の文字を翻訳
nnoremap [tr :<C-u>Translate  <C-r><C-w><CR>
nnoremap ]tr :<C-u>Translate! <C-r><C-w><CR>
