scriptencoding utf-8

augroup MyAutoPairs
    autocmd!
    autocmd BufWinEnter * let g:AutoPairsMapCR = 0 | let g:AutoPairsMapSpace = 0
augroup END
