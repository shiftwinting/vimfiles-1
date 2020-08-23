scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/translator.vim'))
    finish
endif

let g:translator_target_lang = 'ja'
let g:translator_source_lang = 'en'

let g:translator_default_engines = ['google']

vnoremap <silent> <Plug>TranslateWV! :TranslateW!<CR>

xmap     [tr <Plug>TranslateWV
xmap     ]tr <Plug>TranslateWV!
" カーソル下の文字を翻訳
nnoremap [tr :<C-u>TranslateW  <C-r><C-w><CR>
nnoremap ]tr :<C-u>TranslateW! <C-r><C-w><CR>

let g:translator_window_max_height = 0.6
let g:translator_window_max_width = 0.6
