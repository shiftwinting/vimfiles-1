scriptencoding utf-8

" 標準のオブジェクト、関数をハイライト
let g:python_highlight_builtin_objs = 1
let g:python_highlight_builtin_funcs = 1
let g:python_highlight_builtin_types = 1

" self, cls をハイライト
let g:python_highlight_class_vars = 1

" 色強いから止めた
" " str.format をハイライト？
" let g:python_highlight_string_format = 1
"
" " % の strign format をハイライト？
" let g:python_highlight_string_formatting = 1

" ビルトインオブジェクトのハイライト
" None True False __file__ __name__ などなど
let g:python_highlight_builtin_objs = 1

" print() のハイライト
let g:python_print_as_function = 1
