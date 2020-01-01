scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/openbrowser.vim'))
    finish
endif

" netrw の gx のマッピングをさせない
let g:netrw_nogx = 1

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" o : duckduckgo
" d : devdocs.io
" n : なし
" g : github
" m : memo

nnoremap <A-o><A-o> :<C-u>OpenBrowserSearch -duckduckgo 
vnoremap <A-o><A-o> :<C-u>call openbrowser#search(tmg#getwords_last_visual(), 'duckduckgo')<CR>

nnoremap <A-o><A-d> :<C-u>execute 'OpenBrowserSearch -dev ' . &filetype<CR>
nnoremap <A-o><A-n> :<C-u>OpenBrowserSearch -

nnoremap <A-o><A-g> :<C-u>OpenBrowserSearch -gh 
vnoremap <A-o><A-g> :<C-u>call openbrowser#search(tmg#getwords_last_visual(), 'gh')<CR>

nnoremap <A-o><A-m> :<C-u>OpenBrowserSearch -memo 

" 追加
let g:openbrowser_search_engines = {
\   'dev': 'http://devdocs.io/#q={query}',
\   'gh': 'http://github.com/search?q={query}',
\   'duckduckgo': 'http://duckduckgo.com/?q={query}',
\   'memo': 'https://scrapbox.io/tamago324-05149866/search/page?q={query}',
\   'vim': 'https://scrapbox.io/vimemo/search/page?q={query}',
\   'awesome': 'https://vimawesome.com/?q={query}'
\}
