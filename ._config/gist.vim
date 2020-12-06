scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/gist.vim'))
    finish
endif

let g:github_user = 'tamago324'

" 設定方法
" Settings > Developper settingss > Personal access tokens でトークンを作る
" (gist だけでいいのかな？) 
" ~/.gist-vim に以下のように保存する
"   token xxxxxxxx

if has('win32')
    let g:gist_clip_command = 'clip'
endif

" 投稿したらブラウザを開く
let g:gist_open_browser_after_post = 1

" Private なgistも表示する
let g:gist_show_privates = 1

" デフォルトは private
let g:gist_post_private = 1

" 
let g:gist_list_vsplit = 1

" :w! としたときに更新をする
let g:gist_update_on_write = 2
