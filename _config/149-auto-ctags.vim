scriptencoding utf-8

finish

if empty(globpath(&rtp, 'autoload/auto_ctags.vim'))
    finish
endif

" ctags
let g:auto_ctags_tags_args = ['--tag-relative=yes', '--recure=yes', '--sort=yes', '--extra=+f']
" universal ctags
let g:auto_ctags_tags_args = g:auto_ctags_tags_args + ['--output-format=e-ctags']

let g:auto_ctags = 1

" ディレクトリの設定 (先頭から順に見つかったら、そこで終わり)
" .git がなければ、カレントディレクトリに生成する
let g:auto_ctags_directory_list = ['.git', '.']
" 上に見ていくかどうか(？)
let g:auto_ctags_search_recursively = 1
" 絶対パスで生成するか(？)
let g:auto_ctags_absolute_path = 1

for s:dir in g:auto_ctags_directory_list
    if s:dir !=? '.'
        " xxx;$HOME としておくことで $HOME まで検索したら終わりにしてくれる
        execute 'set tags+=./' . s:dir . '/tags' . ';$HOME'
    endif
endfor
