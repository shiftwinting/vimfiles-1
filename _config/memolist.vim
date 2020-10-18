scriptencoding utf-8

if empty(globpath(&rtp, 'autoload/memolist.vim'))
    finish
endif

"なければ作る
if !isdirectory($HOME.'/memo')
    call mkdir($HOME.'/memo')
endif

let g:memolist_path = '~/memo'
nnoremap <Space>mn  :<C-u>MemoNew<CR>
