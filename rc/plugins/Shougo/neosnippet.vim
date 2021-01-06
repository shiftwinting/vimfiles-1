scriptencoding utf-8
UsePlugin 'neosnippet.vim'

" C-L でsunippet を選択開始
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" 非表示文字をどうするか？
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" 自分の snippets
let g:neosnippet#snippets_directory = expand('$MYVIMFILES/snippets')
