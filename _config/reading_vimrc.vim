scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/reading_vimrc.vim'))
    finish
endif

augroup My_reading_vimrc
  autocmd!
  autocmd BufReadCmd readingvimrc://* vmap <buffer> <CR> <Plug>(reading_vimrc-update_clipboard)
augroup END
