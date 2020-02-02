scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/OpenBrowser.vim'))
    finish
endif

nnoremap <silent> <Space>fo :<C-u>Leaderf openbrowser<CR>

" name: url の dict
" LeaderfOpenBrowser で表示できる
let g:Lf_openbrowser_bookmarks = {
\   'vue.js': 'https://jp.vuejs.org/v2/api/',
\   'bulma': 'https://bulma.io/documentation/',
\   'myconfig': 'https://gist.github.com/tamago324/70b98ae1093ed8775587f0d300e3af6c',
\   'thismonth': 'https://scrapbox.io/tamago324-05149866/2020%2F1',
\   'localhost': 'localhost:8080',
\   'buefy': 'https://buefy.org/documentation',
\   'jsprimer': 'https://jsprimer.net/',
\}
