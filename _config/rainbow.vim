scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/rainbow.vim'))
    finish
endif

let g:rainbow_active = 1

let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'guis': [''],
\   'cterms': [''],
\   'operators': '_,_',
\   'contains_prefix': 'TOP',
\   'parentheses_options': '',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': 0,
\   }
\}

" 有効にするファイルタイプ
let s:fts = ['scheme', 'lisp', 'r7rs']
for s:ft in s:fts
    let g:rainbow_conf.separately[s:ft] = {}
endfor

" from slimv.vim
" https://github.com/kovisoft/slimv/blob/b04b425f724deb9b4c60402822832a360075fd99/ftplugin/slimv.vim#L778-L800
" ======
" nord 用
" ======
let s:guifgs = {
\   'dark': [
\       'red1',
\       'orange1',
\       'yellow1',
\       'greenyellow',
\       'green1',
\       'springgreen1',
\       'cyan1',
\       '#b366ff',
\       'magenta1',
\       '#b48ead',
\   ],
\   'light': [
\       'red3',
\       'orangered3',
\       'orange2',
\       'yellow3',
\       'olivedrab4',
\       'green4',
\       'paleturquoise3',
\       'deepskyblue4',
\       'darkslateblue',
\       'darkviolet',
\   ]
\}
" \       'purple1',

let g:rainbow_conf.guifgs = s:guifgs[&background]
