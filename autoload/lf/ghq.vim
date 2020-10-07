scriptencoding utf-8

" ====================
" autoload/lf/ext/ghq.vim
" ====================

py3 from ghqExpl import ghqExplManager
" python3/leaderf_ext/ghq.py をインポートする
py3 from leaderf_ext import ghq

function! lf#ghq#openbrowser() abort
    py3 ghq.open_browser(ghqExplManager)
endfunction

function! lf#ghq#packget() abort
    py3 ghq.packget(ghqExplManager)
endfunction
