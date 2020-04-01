scriptencoding utf-8

finish

if empty(globpath(&rtp, 'autoload/jedi.vim'))
    finish
endif


" 自動の設定を OFF
let g:jedi#auto_vim_configuration = 0

" from module.name<space> で import を補完する
let g:jedi#smart_auto_mappings = 1

" 自動補完を有効
let g:jedi#completions_enabled = 1

" 補完のキー
" <C-l><C-o> でいいや
" let g:jedi#completions_command = '<C-N>'

" ポップアップで表示
let g:jedi#show_call_signatures = 1

" ====================
" キーマッピング
" ====================
" 定義元に行く
let g:jedi#goto_command = 'gd'
let g:jedi#usages_command = 'gu'
let g:jedi#documentation_command = 'K'
