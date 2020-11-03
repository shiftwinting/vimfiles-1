scriptencoding utf-8
UsePlugin 'vim-operator-user'

if !empty(globpath(&rtp, 'autoload/operator/replace.vim'))
    map R <Plug>(operator-replace)
endif
