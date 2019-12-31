scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/neovim_rpc.vim'))
    finish
endif

set pyxversion=3
