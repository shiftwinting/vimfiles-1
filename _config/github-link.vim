scriptencoding utf-8

if empty(globpath(&rtp, 'plugin/github-link.vim'))
    finish
endif

nnoremap <Space>gh :<C-u>GetCurrentCommitLink<CR>
vnoremap <Space>gh :GetCurrentCommitLink<CR>
