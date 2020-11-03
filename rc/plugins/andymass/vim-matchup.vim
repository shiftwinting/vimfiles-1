scriptencoding utf-8

UsePlugin 'vim-matchup'

" ハイライトを少し遅らせる (hjkl の移動がスムーズになる？)
let g:matchup_matchparen_deferred = 1

" マッチ対象を表示させない
" let g:matchup_matchparen_offscreen = {}

" 指定のモードではハイライトさせない
let g:matchup_matchparen_nomode = 'i'
" let g:matchup_matchparen_nomode = ''

" popup で表示する
let g:matchup_matchparen_offscreen = {'method': 'popup'}
