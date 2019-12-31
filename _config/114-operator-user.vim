scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/operator/user.vim'))
    finish
endif


if !empty(globpath(&rtp, 'autoload/operator/replace.vim'))
    map R <Plug>(operator-replace)
endif
