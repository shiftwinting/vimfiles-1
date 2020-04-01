scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/kite.vim'))
    finish
endif


" サポートする言語 ('go' もあるらしい)
let g:kite_supported_languages = ['python']

" 自動補完
let g:kite_auto_complete = 1

" Kite が用意している snippets
let g:kite_snippets = 1

" 前
let g:kite_previous_placeholder = '<C-K>'
" 次
let g:kite_next_placeholder = '<C-J>'

" カーソルのやつをKiteにドキュメントを表示する
let g:kite_documentation_continual = 0

" 補完のポップアップの横幅の MAX
let g:kite_completion_max_width = 75


augroup MyKite
    autocmd!
    autocmd FileType python nnoremap K <Plug>(kite-docs)
augroup END
