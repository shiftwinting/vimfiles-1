scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/completor.vim'))
    finish
endif

let g:completor_clang_binary = 'C:/Program Files/LLVM/bin/clang.exe'

" let g:completor_clang_disable_placeholders = 1

let g:completor_min_chars = 2

let g:completor_complete_options = &completeopt

" ファイル名の補完は、コメント or String のときのみにする
let g:completor_filename_completion_in_only_comment = 1

let g:completor_completion_delay = 30

let g:completor_debug = 1
