scriptencoding utf-8

" https://7me.oji.0j0.jp/2018/vim-table-mode-memo.html

" let g:table_mode_map_prefix = '<Space>t'
" markdownに対応するため
let g:table_mode_corner='|'
" デフォルトのmappingを無効化
let g:table_mode_disable_mappings = 1

" 自動で整える
let g:table_mode_auto_align = 1
" table-modeのトグル
" let g:table_mode_toggle_map = 'm'

nnoremap <F4> :<C-u>%Tableize<CR>
