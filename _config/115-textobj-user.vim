scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/textobj-user'))
    finish
endif

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

