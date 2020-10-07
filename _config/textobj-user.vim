scriptencoding utf-8

if !empty(globpath(&rtp, 'autoload/textobj/multiblock.vim'))
    " b
    omap ab <Plug>(textobj-multiblock-a)
    omap ib <Plug>(textobj-multiblock-i)
    xmap ab <Plug>(textobj-multiblock-a)
    xmap ib <Plug>(textobj-multiblock-i)
endif

if !empty(globpath(&rtp, 'autoload/textobj/function.vim'))
    " f
    omap af <Plug>(textobj-function-A)
    omap if <Plug>(textobj-function-I)
endif

if !empty(globpath(&rtp, 'autoload/textobj/line.vim'))
    " l
    omap al <Plug>(textobj-line-A)
    omap il <Plug>(textobj-line-I)
endif



if !empty(globpath(&rtp, 'autoload/textobj/indent.vim'))
    " l
    omap al <Plug>(textobj-indent-A)
    omap il <Plug>(textobj-indent-I)
endif