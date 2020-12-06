scriptencoding utf-8

if empty(globpath(&rtp, 'ftplugin/slimv.vim'))
    finish
endif

" sbcl を使う
let g:slimv_impl = 'sbcl'

" 一応、設定
let g:slimv_preferred = 'sbcl'

" swank の実行 (サーバー？)
let g:slimv_swank_cmd = printf('!start "c:/SBCL/1.4.14/sbcl.exe" --load "%s"', expand('~/vimfiles/plugged/slimv/slime/start-swank.lisp'))

" カッコを rainbow 
let g:lisp_rainbow = 1

" keybindings の type は 1
let g:slimv_keybindings = 1

" paredir の Leader
let g:paredit_leader = ','

" < > S でできる
let g:paredit_shortmaps = 1
