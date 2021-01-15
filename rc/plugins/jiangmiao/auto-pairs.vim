scriptencoding utf-8
UsePlugin 'auto-pairs'

augroup MyAutoPairs
    autocmd!
    autocmd BufWinEnter * let g:AutoPairsMapCR = 0 | let g:AutoPairsMapSpace = 0
    " slimv を使うため
    autocmd Filetype lisp,scheme let b:autopairs_enabled = 0
augroup END

" let g:AutoPairsShortcutToggle = '<M-p>'
let g:AutoPairsShortcutToggle = ''

" let g:AutoPairsShortcutFastWrap = '<M-e>'
let g:AutoPairsShortcutFastWrap = ''

" let g:AutoPairsShortcutJump = '<M-n>'
let g:AutoPairsShortcutJump = ''

" let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsShortcutBackInsert = ''

