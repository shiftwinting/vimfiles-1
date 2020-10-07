scriptencoding utf-8

" ====================
" autoload/lf/ext/ghq.vim
" ====================

" python3/leaderf_ext/ghq.py をインポートする
py3 from leaderf_ext import ghq

function! lf#ext#ghq#openbrowser() abort
    py3 ghq.open_browser()
endfunction

function! lf#ext#ghq#packget() abort
    py3 ghq.packget()
endfunction
