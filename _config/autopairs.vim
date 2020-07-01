scriptencoding utf-8

augroup MyAutoPairs
    autocmd!
    autocmd BufWinEnter * let g:AutoPairsMapCR = 0 | let g:AutoPairsMapSpace = 0
    " slimv を使うため
    autocmd Filetype lisp,scheme let b:autopairs_enabled = 0
augroup END
