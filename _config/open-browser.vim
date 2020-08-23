scriptencoding utf-8

" netrw の gx のマッピングをさせない
let g:netrw_nogx = 1

let g:openbrowser_default_search = 'duckduckgo'

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" d : devdocs.io
" g : github
" j : 

nnoremap <A-o><A-d> :<C-u>execute 'OpenBrowserSearch -devdocs ' . &filetype<CR>
nnoremap <A-o><A-g> :<C-u>OpenBrowserSmartSearch -github 
nnoremap <A-o><A-o> :<C-u>OpenBrowserSmartSearch 
nnoremap <A-o><A-m> :<C-u>OpenBrowserSmartSearch https://scrapbox.io/tamago324-05149866<CR>

" 追加
let g:openbrowser_search_engines = {
\   'devdocs': 'http://devdocs.io/#q={query}',
\   'github': 'http://github.com/search?q={query}',
\   'vimawesome': 'https://vimawesome.com/?q={query}',
\   'duckduckgo': 'http://duckduckgo.com/?q={query}',
\   'memo': 'https://scrapbox.io/tamago324-05149866/search/page?q={query}',
\   'mdnwebdocs': 'https://developer.mozilla.org/ja/search?q={query}',
\   'python': 'https://docs.python.org/3/search.html?q={query}'
\}
