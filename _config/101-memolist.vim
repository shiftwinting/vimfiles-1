scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/memolist.vim'))
    finish
endif

let g:memolist_path = '~/memo'
nnoremap <Space>mn  :<C-u>MemoNew<CR>
