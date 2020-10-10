scriptencoding utf-8

" C-L でsunippet を選択開始
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" C-L で次の項目に移動
" xmap <C-j> <Plug>(neosnippet_expand_target)

" TODO: 理解する
" 非表示文字をどうするか？
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" 自分の snippets
let g:neosnippet#snippets_directory = expand('$MYVIMFILES/snippets')

augroup MySnippets
    autocmd!
    autocmd Filetype neosnippet setlocal noexpandtab
augroup END
