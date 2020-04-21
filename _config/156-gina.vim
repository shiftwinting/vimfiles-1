scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/gina.vim'))
    finish
endif

" ====================
" action#alias
" ====================

" gina-xxxx に alias を追加
call gina#custom#action#alias(
\   'status', 'redit',
\   'edit:right'
\)

" " /{pattern} で正規表現で書ける？
" call gina#custom#action#alias(
" \   '/*', 'redit',
" \   'edit:right'
" \

" ====================
" action#shorten
" ====================

" " gina-status で show: を省略できるようになる
" "    show:preview => preview
"  call gina#custom#action#shorten('status', 'show')
