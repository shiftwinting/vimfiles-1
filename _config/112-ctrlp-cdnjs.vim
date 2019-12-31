scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/ctrlp/cdnjs.vim'))
    finish
endif

" C-t でタグを挿入
" insert するタグ
let g:ctrlp_cdnjs_script_tag = '<script src="${url}"></script>'
" https
let g:ctrlp_cdnjs_scheme = 2
