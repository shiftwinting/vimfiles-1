scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/gotest.vim'))
    finish
endif

" 保存時に `:GoFmt` を実行しないようにする
let g:go_fmt_autosave = 0

" snippet プラグインを指定
let g:go_snippet_engine = 'neosnippet'

augroup MyVimGo
    autocmd!
    autocmd FileType go call s:settings()
augroup END

function! s:settings() abort
    inoremap <buffer> . .<C-x><C-o>
endfunction
