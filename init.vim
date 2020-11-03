scriptencoding utf-8

augroup NvimInit
    autocmd!
    autocmd VimEnter * ++once lua require('init')
augroup END
