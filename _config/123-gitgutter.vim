scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/gitgutter.vim'))
    finish
endif

" 起動時に有効化
let g:gitgutter_enabled = 1
" OFF default mappings
let g:gitgutter_map_keys = 0

augroup MyGutter
    autocmd!
    autocmd BufWritePost * GitGutter
augroup END

" plugin で定義済の autocmd を削除
augroup gitgutter
    autocmd!
augroup END

" 変更箇所へ移動
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)

" stage/unstage
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ght :<C-u>GitGutterSignsToggle<CR>
nmap ghf :<C-u>GitGutterFold<CR>
nmap ghp :<C-u>GitGutterPreviewHunk<CR>
