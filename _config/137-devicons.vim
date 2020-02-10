scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/webdevicons.vim'))
    finish
endif

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ''
