scriptencoding utf-8

" 標準のオブジェクト、関数をハイライト
" 以下の3つが有効になる
" g:python_highlight_builtin_objs
" g:python_highlight_builtin_funcs
" g:python_highlight_builtin_types
let g:python_highlight_builtins = 1

" self, cls をハイライト
let g:python_highlight_class_vars = 1

" 色強いから止めた
" " str.format をハイライト？
" let g:python_highlight_string_format = 1
"
" " % の strign format をハイライト？
" let g:python_highlight_string_formatting = 1
