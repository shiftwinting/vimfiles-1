scriptencoding utf-8
UsePlugin 'wilder.nvim'

call wilder#enable_cmdline_enter()
set wildcharm=<Tab>

" cmap <expr> <C-n> wilder#in_context() ? wilder#next() : "\<Down>"
" cmap <expr> <C-p> wilder#in_context() ? wilder#previous() : "\<Up>"
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

call wilder#set_option('modes', [':'])

" call wilder#set_option('pipeline', [
"       \   wilder#branch(
"       \     wilder#python_file_finder_pipeline({
"       \       'file_command': ['find', '.', '-type', 'f', '-printf', '%P\n'],
"       \       'dir_command': ['find', '.', '-type', 'd', '-printf', '%P\n'],
"       \       'filters': ['fuzzy_filter', 'difflib_sorter'],
"       \     }),
"       \     wilder#cmdline_pipeline(),
"       \     wilder#python_search_pipeline(),
"       \   ),
"       \ ])

call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))
