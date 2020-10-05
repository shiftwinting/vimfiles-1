scriptencoding utf-8

finish

if empty(globpath(&rtp, 'autoload/mucomplete.vim'))
    finish
endif

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#complete_delay = 30

let g:mucomplete#no_mappings = 0

let g:mucomplete#chains = {}

let g:mucomplete#chains.default = ['omni', 'keyn', 'defs']
let g:mucomplete#chains.py = ['nsnp', 'omni', 'keyn', 'defs']
let g:mucomplete#chains.c = ['nsnp', 'omni', 'keyn', 'defs']
