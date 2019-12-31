scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/emmet.vim'))
    finish
endif

" mattn/emmet-vim
let g:user_emmet_settings = {
\   'variables': {
\       'lang': 'ja'
\   }
\}

" mappings
" <C-y>, : 展開
" <C-y>; : 展開 (ただのタグ)
" v_<C-y>, : 選択範囲を指定の要素で囲む
