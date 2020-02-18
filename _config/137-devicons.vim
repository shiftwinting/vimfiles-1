scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/webdevicons.vim'))
    finish
endif

" http://bit.ly/2SftwnP
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ''
