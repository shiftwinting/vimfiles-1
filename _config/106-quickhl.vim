scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/quickhl.vim'))
    finish
endif

nmap <Space>mm <Plug>(quickhl-manual-this)
xmap <Space>mm <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
