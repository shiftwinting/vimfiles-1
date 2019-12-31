scriptencoding utf-8

if empty(globpath(&rtp, 'ftplugin/vue.vim'))
    finish
endif

augroup MyVue
    autocmd!
    autocmd FileType vue syntax sync fromstart
augroup END
