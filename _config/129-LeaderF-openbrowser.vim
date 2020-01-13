scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/OpenBrowser.vim'))
    finish
endif

nnoremap <silent> <A-o><A-o> :<C-u>Leaderf openbrowser --popup<CR>

" name: url の dict
" LeaderfOpenBrowser で表示できる
let g:Lf_openbrowser_bookmarks = {
\   'vue.js': 'https://jp.vuejs.org/v2/api/',
\   'bulma': 'https://bulma.io/documentation/',
\   'myconfig': 'https://gist.github.com/tamago324/70b98ae1093ed8775587f0d300e3af6c',
\   'thismonth': 'https://scrapbox.io/tamago324-05149866/2020%2F1',
\   'windows-cmd': 'https://scrapbox.io/tamago324-05149866/Windows_%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E5%9F%BA%E7%A4%8E',
\   'cheatsheet': 'https://scrapbox.io/tamago324-05149866/%E3%81%A1%E3%83%BC%E3%81%A8%E3%81%97%E3%83%BC%E3%81%A8',
\   'localhost': 'localhost:8080',
\}
