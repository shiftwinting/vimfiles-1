scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/matchup.vim'))
    finish
endif

" Insertモードになったら、ハイライトを消す
augroup MyMatchup
    autocmd!
    autocmd InsertEnter * NoMatchParen
    autocmd InsertLeave * DoMatchParen
augroup END

