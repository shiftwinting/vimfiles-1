scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/leaderf/Ghq.vim'))
    finish
endif

let g:Lf_GhqAcceptSelectionCmd = 'tabe | Leaderf! filer'

nnoremap <silent> <Space>fq :<C-u>Leaderf ghq<CR>
