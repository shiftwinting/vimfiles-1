scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/translate.vim'))
    finish
endif

let g:translate_source = 'en'
let g:translate_target = 'ja'
let g:translate_popup_window = 1

xmap     [tr :<C-u>exec 'Translate ' . vimrc#getwords_last_visual()<CR>
xmap     ]tr :<C-u>exec 'Translate! ' . vimrc#getwords_last_visual()<CR>
" カーソル下の文字を翻訳
nnoremap [tr :<C-u>Translate  <C-r><C-w><CR>
nnoremap ]tr :<C-u>Translate! <C-r><C-w><CR>
