scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/nrrwrgn.vim'))
    finish
endif


vnoremap <Space>nr :NR<CR>
