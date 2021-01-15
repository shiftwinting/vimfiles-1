scriptencoding utf-8
UsePlugin 'vim-github-link'

nnoremap <Space>gh :<C-u>GetCurrentCommitLink<CR>
vnoremap <Space>gh :GetCurrentCommitLink<CR>
