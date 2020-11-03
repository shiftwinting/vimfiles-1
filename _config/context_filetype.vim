scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/context_filetype.vim'))
    finish
endif

let g:context_filetype#filetypes = get(g:, 'context_filetype#filetypes', {})

" help では実行しないようにする
let g:context_filetype#filetypes['help'] = {}
