scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/translator.vim'))
    finish
endif

let g:translator_target_lang = 'ja'
let g:translator_source_lang = 'en'

let g:translator_default_engines = ['google']

vnoremap <silent> <Plug>TranslateWV! :TranslateW!<CR>

" xmap     [tr <Plug>TranslateWV
" xmap     ]tr <Plug>TranslateWV!
xmap     [tr :<C-u>call <SID>translate(0)<CR>
xmap     ]tr :<C-u>call <SID>translate(1)<CR>

" カーソル下の文字を翻訳
nnoremap [tr :<C-u>TranslateW  <C-r><C-w><CR>
nnoremap ]tr :<C-u>TranslateW! <C-r><C-w><CR>

function! s:replace_chars(str) abort
    return substitute(a:str, '`', "'", 'g')
endfunction
function! s:translate(bang) abort
    " 選択していた文字を取得する
    let l:str = s:replace_chars(vimrc#getwords_last_visual())
    if a:bang
        exec 'TranslateW! ' . l:str
    else
        exec 'TranslateW ' . l:str
    endif
endfunction

let g:translator_window_max_height = 0.6
let g:translator_window_max_width = 0.6
