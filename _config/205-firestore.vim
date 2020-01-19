scriptencoding utf-8

if empty(globpath(&rtp, 'ftplugin/firestore.vim'))
    finish
endif

" 警告をハイライトしない
let g:vim_firestore_warnings = 0
