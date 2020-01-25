scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/coc.vim'))
    finish
endif

" g(oto)
nmap gi <Plug>(coc-implementation)
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
nmap ga <Plug>(coc-codeaction)

nmap <Space>bl <Plug>(coc-format)
