scriptencoding utf-8

" スペースのペアを無くす
let g:AutoPairsMapSpace = 0

augroup MyAutoPairs
    autocmd!
    autocmd BufWinEnter * let g:AutoPairsMapCR = 0
augroup END
