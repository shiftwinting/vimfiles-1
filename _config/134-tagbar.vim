scriptencoding utf-8

nnoremap <Space>to :<C-u>TagbarOpenAutoClose<CR>

" 開いたら、自動でフォーカスを移す
let g:tagbar_autofocus = 1

" タグにジャンプしたら、自動で閉じる
let g:tagbar_autoclose = 1

" r で sort
let tagbar_map_togglesort = 'r'

" インデントの幅
let g:tagbar_indent = 1
