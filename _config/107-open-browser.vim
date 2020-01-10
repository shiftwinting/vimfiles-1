scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/openbrowser.vim'))
    finish
endif

" netrw の gx のマッピングをさせない
let g:netrw_nogx = 1

let g:openbrowser_default_search = 'duckduckgo'

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" d : devdocs.io
" g : github

nnoremap <A-o><A-d> :<C-u>execute 'OpenBrowserSearch -devdocs ' . &filetype<CR>
nnoremap <A-o><A-g> :<C-u>OpenBrowserSmartSearch -github 

" 追加
let g:openbrowser_search_engines = {
\   'devdocs': 'http://devdocs.io/#q={query}',
\   'github': 'http://github.com/search?q={query}',
\   'vimawesome': 'https://vimawesome.com/?q={query}',
\   'duckduckgo': 'http://duckduckgo.com/?q={query}',
\   'memo': 'https://scrapbox.io/tamago324-05149866/search/page?q={query}',
\}

" name: url の dict
" LeaderfOpenBrowser で表示できる
let g:openbrowser_bookmarks = {
\   'vue.js': 'https://jp.vuejs.org/v2/api/',
\   'bulma': 'https://bulma.io/documentation/',
\   'myconfig': 'https://gist.github.com/tamago324/70b98ae1093ed8775587f0d300e3af6c',
\}
