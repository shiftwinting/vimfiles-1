UsePlugin 'wilder.nvim'
scriptencoding utf-8

call wilder#enable_cmdline_enter()

set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" call wilder#set_option('pipeline', [
" \   wilder#branch(
" \     [
" \       wilder#check({_, x -> empty(x)}),
" \       wilder#history(100),
" \     ],
" \     wilder#cmdline_pipeline(),
" \     wilder#python_search_pipeline({
" \       'fuzzy': 1,
" \     }),
" \   ),
" \ ])
