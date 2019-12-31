scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/translate.vim'))
    finish
endif

xmap     [tr <Plug>(VTranslate)
xmap     ]tr <Plug>(VTranslateBang)
" カーソル下の文字を翻訳
nnoremap [tr :<C-u>Translate  <C-r><C-w><CR>
nnoremap ]tr :<C-u>Translate! <C-r><C-w><CR>
