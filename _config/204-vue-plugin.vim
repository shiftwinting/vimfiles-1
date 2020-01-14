scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/vue.vim'))
    finish
endif

" https://vuejsexamples.com/vim-syntax-and-indent-plugin-for-vue-files/

" すべての syntax file を追加する
" JavaScript / HTML / CSS / SASS / LESS
"let g:vim_vue_plugin_load_full_syntax = 0

" <template lang="pug"> の構文ハイライトを有効にする
"let g:vim_vue_plugin_use_pug = 0

" <style lang="coffee"> の構文ハイライトを有効にする
"let g:vim_vue_plugin_use_coffee = 0

" <style lang="less"> の構文ハイライトを有効にする
"let g:vim_vue_plugin_use_less = 0

" <style lang="scss"> / lang="sass" の構文ハイライトを有効にする
"let g:vim_vue_plugin_use_sass = 0

" style/script タグ内で Javascript のインデントを有効にする
let g:vim_vue_plugin_has_init_indent = 1

" タグの vue の属性値を文字列ではなく、式としてハイライトする
let g:vim_vue_plugin_highlight_vue_attr = 1

" メソッドを折りたたむか
"let g:vim_vue_plugin_use_foldexpr = 0

" Debug 用
"let g:vim_vue_plugin_debug = 0

